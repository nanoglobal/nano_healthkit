//
import HealthKit
import HealthKitUI
//import RxSwift

class AppleHealthDataFetcher: NSObject {
    
    var isFetchingData = false
    
    override init() {
        super.init()
    }
    
    func requestPermissions(completion: @escaping (Bool, Error?) -> Void) {
        
        // Make an all types set that
        let allTypes = getSimpleAllSampleTypes(origin: getAllSampleTypes())
        
        AppleHealthUtils.healthStore?.requestAuthorization(toShare: nil, read: allTypes) { success, error in
            completion(success, error)
        }
    }
    
    func sendData(_ data: [HealthKitData]?) {
        //TODO: Send to Flutter
    }
    
    func unsubscribeToUpdates() {
        
        unsubscribeToUpdates(completion: { success, error in
            // Do nothing extra
        })
    }
    
    private func unsubscribeToUpdates(completion: @escaping (Bool, Error?) -> Void) {
        AppleHealthUtils.healthStore?.disableAllBackgroundDelivery(completion: completion)
    }
    
    func subscribeToUpdates(completion: @escaping (Bool, Error?) -> Void) {
        
        // First unsubscribe, once finished subscribe
        unsubscribeToUpdates(completion: { success, error in
            
            // If service is not active, exit
            //if !(self.sharedMemory.appleHealthRecord?.serviceIsActive ?? false) {
            //    completion(false, SimpleLocalizedError("applehealth_cant_subscribe"))
            //    return
            //}
            
            // Subscribe
            self.subscribeToAllSampleTypes(completion: completion)
        })
    }
    
    private func subscribeToAllSampleTypes(completion: @escaping (Bool, Error?) -> Void) {
        
        // Make an all types set that
        let allTypes = getAllSampleTypes()
        
        // For each type, subscribe
        for (index, touple) in allTypes.enumerated() {
            
            AppleHealthUtils.healthStore?.enableBackgroundDelivery(for: touple.0, frequency: .immediate, withCompletion: {
                [weak self] success, error in
                
                print("AppleHealth background delivery setup responded")
                
                // If fails do nothing
                if !success || error != nil || self == nil {
                    print("AppleHealth background delivery failed and will exit success: \(success) and error: \(error?.localizedDescription ?? "")")
                    completion(false, SimpleLocalizedError("applehealth_cant_subscribe"))
                    abort()
                }
                
                let query = self!.subscribeQuery(for: touple, completion: completion)
                AppleHealthUtils.healthStore?.execute(query)
                
                // On last subscribe, call completition
                if index == (allTypes.count - 1) {
                    completion(true, nil)
                }
            })
        }
    }
    
    private func subscribeQuery(for touple: (HKSampleType, AppleHealthFetchTypes, Int), completion: @escaping (Bool, Error?) -> Void) -> HKObserverQuery {
        
        return HKObserverQuery(sampleType: touple.0, predicate: nil) {
            [weak self] query, completionHandler, error in
            
            print("AppleHealth observer query called: \(query.objectType?.description ?? "") and touple: \(touple.0.description) and error: \(error?.localizedDescription ?? "")")
            
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the observer. \(error?.localizedDescription ?? "") ***")
                return // abort()
            }
            
            // Fetch the changes
            var hkAnchor = self?.getAnchor(anchorKey: touple.0.description)
            if hkAnchor == nil {
                hkAnchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
            }
            
            let onAnchorQueryResults: ((HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void)! = {
                (query: HKAnchoredObjectQuery, addedObjects: [HKSample]?, deletedObjects: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, nsError: Error?) -> Void in
                
                if addedObjects != nil && addedObjects?.count ?? 0 > 0 {
                    print("There were samples for touple: \(touple.0.description)")
                    let data = self?.makeData(from: addedObjects, fetchType: touple.1, index: touple.2, sampleType: touple.0)
                    self?.sendData(data)
                }
                
                // NOTE: There's no way to delete values on current api version so it will be ignored for now
                
                // TODO: check this
                if newAnchor != nil && newAnchor != hkAnchor {
                    self?.saveAnchor(anchor: newAnchor!, anchorKey: touple.0.description)
                }
                
                completionHandler()
            }
            let anchoredQuery = HKAnchoredObjectQuery(type: touple.0, predicate: nil, anchor: hkAnchor, limit: HKObjectQueryNoLimit, resultsHandler: onAnchorQueryResults)
            AppleHealthUtils.healthStore?.execute(anchoredQuery)
        }
    }
    
    func fetchAllHistoricData(record: AppleHealthStatusRecord, completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        // If record exists and is finished, exit
        if record.readAllHasCompleted {
            completion(true, nil)
            return
        }
        
        // If it was already running dont continue
        if isFetchingData {
            completion(false, SimpleLocalizedError("applehealth_already_fetching"))
            return
        }
        isFetchingData = true
        
        moveToNextHistoricData(record: record, completion: completion)
    }
    
    private func moveToNextHistoricData(record: AppleHealthStatusRecord, completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        // Move to the next value
        record.readIndex = record.readIndex + 1
        // If there is no next in the current type, move to the next
        if record.readIndex >= AppleHealthUtils.ALL_TYPES[record.readType].count {
            record.readIndex = 0
            record.readType = record.readType + 1
        }
        // If there is no next, mark as completed
        if record.readType >= AppleHealthUtils.ALL_TYPES.count {
            record.readIndex = 0
            record.readType = 0
            record.readAllHasCompleted = true
        }
        
        // Save the record
        AppleHealthUtils.saveRecord(record)
        
        // If is finished then exit
        if record.readAllHasCompleted {
            isFetchingData = false
            completion(true, nil)
            return
        }
        
        // Call the fetch
        let fetchType = AppleHealthFetchTypes(rawValue: record.readType)!
        fetchData(for: fetchType, index: record.readIndex, record: record, completion: completion)
    }
    
    private func fetchData(for fetchType: AppleHealthFetchTypes, index: Int, record: AppleHealthStatusRecord, completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        // Get the object type
        let sampleType = getObjectType(for: fetchType, index: index)
        // Note: Here we would check for permissions for reading but apple doesnt grant information about it, only for writing
        if sampleType == nil {
            moveToNextHistoricData(record: record, completion: completion)
            return
        }
        
        // 1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType!,
                                        predicate: mostRecentPredicate,
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [sortDescriptor]) { [weak self] query, samples, error in
                                            
                                            if error != nil {
                                                self?.isFetchingData = false
                                                completion(false, error)
                                                return // abort()
                                            }
                                            
                                            let data = self?.makeData(from: samples, fetchType: fetchType, index: index, sampleType: sampleType!)
                                            self?.sendData(data)
                                            
                                            self?.moveToNextHistoricData(record: record, completion: completion)
        }
        
        AppleHealthUtils.healthStore?.execute(sampleQuery)
    }
    
    
    
    func makeData(from samples: [HKSample]?, fetchType: AppleHealthFetchTypes, index: Int, sampleType: HKSampleType) -> [HealthKitData] {
        
        var data: [HealthKitData] = []
        for sample: HKSample in samples ?? [] {
            
            var singleData: HealthKitData? = nil
            if let workoutSample = sample as? HKWorkout {
                singleData = saveAsData(type: sampleType, value: workoutSample, index: index)
            } else if let quantitySample = sample as? HKQuantitySample {
                singleData = saveAsData(type: sampleType, value: quantitySample, index: index)
            } else if let categorySample = sample as? HKCategorySample {
                singleData = saveAsData(type: sampleType, value: categorySample, index: index)
            }
            
            if singleData != nil {
                data.append(singleData!)
            }
        }
        return data
        
    }
    
    /*private func saveSampleInDb(samples: [HKSample]?, fetchType: AppleHealthFetchTypes, index: Int, sampleType: HKSampleType) {
        
        let dbUtils = DBUtils()
        
        for sample: HKSample in samples ?? [] {
            
            var jsonRes: [String: Any]?
            if let workoutSample = sample as? HKWorkout {
                jsonRes = AppleHealthDataFetcher.saveInJson(type: sampleType, value: workoutSample, index: index)
            } else if let quantitySample = sample as? HKQuantitySample {
                jsonRes = AppleHealthDataFetcher.saveInJson(type: sampleType, value: quantitySample, index: index)
            } else if let categorySample = sample as? HKCategorySample {
                jsonRes = AppleHealthDataFetcher.saveInJson(type: sampleType, value: categorySample, index: index)
            }
            
            if jsonRes != nil, let dataString = String.fromJson(jsonRes!) {
                let data = AppleHealthData()
                data.dataType = fetchType.rawValue
                data.dataIndex = index
                data.dataString = dataString
                dbUtils.save(object: data)
            }
        }
    }*/
    
    // MARK: Aux methods
    
    private func getAllSampleTypes() -> [(HKSampleType, AppleHealthFetchTypes, Int)] {
        
        var allTypes: [(HKSampleType, AppleHealthFetchTypes, Int)] = []
        for typeIndex in 0 ..< AppleHealthUtils.ALL_TYPES.count {
            let fetchType = AppleHealthFetchTypes(rawValue: typeIndex)!
            let typeArray = AppleHealthUtils.ALL_TYPES[typeIndex]
            for index in 0 ..< typeArray.count {
                if let sampleType = getObjectType(for: fetchType, index: index) {
                    let touple = (sampleType, fetchType, index)
                    allTypes.append(touple)
                }
            }
        }
        return allTypes
    }
    
    private func getSimpleAllSampleTypes(origin: [(HKSampleType, AppleHealthFetchTypes, Int)]) -> Set<HKSampleType> {
        
        var allTypes: Set<HKSampleType> = Set()
        for touple in origin {
            allTypes.insert(touple.0)
        }
        return allTypes
    }
    
    private func getObjectType(for fetchType: AppleHealthFetchTypes, index: Int) -> HKSampleType? {
        
        var sampleType: HKSampleType?
        if fetchType == .categories {
            sampleType = HKObjectType.categoryType(forIdentifier: AppleHealthUtils.CATEGORY_TYPES[index])
        } else if fetchType == .quantities {
            sampleType = HKObjectType.quantityType(forIdentifier: AppleHealthUtils.QUANTITY_TYPES[index].0)
        } else if fetchType == .workout {
            sampleType = AppleHealthUtils.WORKOUT_TYPES[index]
        }
        return sampleType
    }
    
    func saveAsDataBase(type: HKSampleType, value: HKSample) -> HealthKitData {
        
        var data = HealthKitData()
        data.type = type.description
        data.startDate = value.startDate.iso8601
        data.endDate = value.endDate.iso8601
        data.device = value.device?.name ?? ""
        data.metadata = jsonToString(value.metadata)
        return data
    }
    
    private func jsonToString(_ jsonDictionary: [String: Any]?) -> String {
        
        if let jsonDictionary = jsonDictionary, let theJSONData = try? JSONSerialization.data(
            withJSONObject: jsonDictionary, options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            return theJSONText ?? ""
        }
        return ""
    }
    
    func saveAsData(type: HKSampleType, value: HKQuantitySample, index: Int) -> HealthKitData {
        
        var data = saveAsDataBase(type: type, value: value)
        if #available(iOS 12.0, *) {
            data.count = Int64(value.count)
        }
        if let unit = AppleHealthUtils.QUANTITY_TYPES[index].1 {
            data.quantityUnit = unit.unitString
            data.quantity = value.quantity.doubleValue(for: unit)
        }
        return data
    }
    
    func saveAsData(type: HKSampleType, value: HKCategorySample, index: Int) -> HealthKitData {
        
        var data = saveAsDataBase(type: type, value: value)
        data.value = Int64(value.value)
        return data
    }
    
    func saveAsData(type: HKSampleType, value: HKWorkout, index: Int) -> HealthKitData {
        
        var data = saveAsDataBase(type: type, value: value)
        data.totalEnergyBurned = value.totalEnergyBurned?.doubleValue(for: .joule()) ?? 0
        data.totalEnergyBurnedUnit = HKUnit.joule().unitString
        data.totalDistance = value.totalDistance?.doubleValue(for: .meter()) ?? 0
        data.totalDistanceUnit = HKUnit.meter().unitString
        data.duration = value.duration
        return data
    }
    
    private func getAnchor(anchorKey: String) -> HKQueryAnchor? {
        
        let encoded = UserDefaults.standard.data(forKey: anchorKey)
        if encoded == nil {
            return nil
        }
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: encoded!) as? HKQueryAnchor
        return anchor
    }
    
    private func saveAnchor(anchor: HKQueryAnchor, anchorKey: String) {
        
        let encoded = NSKeyedArchiver.archivedData(withRootObject: anchor)
        UserDefaults.standard.setValue(encoded, forKey: anchorKey)
        UserDefaults.standard.synchronize()
    }
    
    
}

// MARK - Helpers

struct SimpleLocalizedError: LocalizedError {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String? = nil, _ description: String, code: Int = 0) {
        self.title = title == nil ? "error_generic_title" : title
        self._description = description
        self.code = code
    }
}

extension Formatter {
    
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}

extension Date {
    
    init(fromMillis: Int64?) {
        self = Date(timeIntervalSince1970: TimeInterval((fromMillis ?? 0) / 1000))
    }
    
    // Note: ISO8601 string format: yyyy-MM-dd'T'HH:mm:ss.SSSZ.
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
