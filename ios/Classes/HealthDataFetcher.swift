//
import HealthKit

class HealthDataFetcher: NSObject {
    
    // MARK: Data fetching
    
    struct BatchParams {
        let startDate: Date
        let endDate: Date
        let limit: Int
        let sort: NSSortDescriptor
        let units: [HKUnit]
    }
    
    struct StatisticsParams {
        let startDate: Date
        let endDate: Date
        let statisticsOptions: HKStatisticsOptions
    }
    
    func fetchBatchData(for healthType: HealthTypes, params: BatchParams, result: @escaping (HealthDataList?, Error?) -> Swift.Void) {
        
        // Note: Here we would check for permissions for reading but apple doesnt grant information about it, only for writing
        guard let sampleType = HealthDataUtils.getHKObjectType(for: healthType) as? HKSampleType else {
            result(nil, SimpleLocalizedError("Invalid sample type"))
            return
        }
        
        // Use HKQuery to load the most recent samples.
        let timePredicate = HKQuery.predicateForSamples(withStart: params.startDate,
                                                        end: params.endDate,
                                                        options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: timePredicate,
                                  limit: params.limit,
                                  sortDescriptors: [params.sort]) { [weak self] query, samples, error in
            
            if error != nil {
                result(nil, error)
                return
            }
            
            let data = self?.makeDataList(from: samples, sampleType: sampleType, units: params.units, healthType: healthType)
            result(data, nil)
        }
        
        HealthDataUtils.healthStore?.execute(query)
    }
    
    func fetchCharacteristicData(for healthType: HealthTypes, healthStore: HKHealthStore, result: @escaping (HealthDataList?, Error?) -> Swift.Void) {
        
        guard let index = HealthDataUtils.getTypeIndex(healthType),
            let characteristicType = HealthDataUtils.getHKObjectType(for: healthType) as? HKCharacteristicType else {
            result(nil, SimpleLocalizedError("Invalid sample type"))
            return
        }
        
        let characteristic = HealthDataUtils.CHARACTERISTIC_TYPES[index.0]
        let data = makeDataList(from: [(healthStore, characteristic.1)], sampleType: characteristicType, units: [], healthType: healthType)
        result(data, nil)
    }
    
    // MARK: Subscriptions
    
    func unsubscribeToUpdates(result: @escaping (Bool, Error?) -> Void) {
        
        for query in HealthDataUtils.subscriptionQueries {
            HealthDataUtils.healthStore?.stop(query)
        }
        HealthDataUtils.healthStore?.disableAllBackgroundDelivery(completion: result)
    }
    
    func subscribeToUpdates(for healthTypeList: HealthTypeList, healthStore: HKHealthStore, result: @escaping (Bool, Error?) -> Void) {
        
        // First unsubscribe, once finished subscribe
        unsubscribeToUpdates(result: { [weak self] success, error in
            
            if self == nil {
                return
            }
            
            // Subscribe
            HealthDataUtils.subscriptionQueries = []
            
            // Filter all unexisting types and only types that can be Sampled
            let filteredTypes: [(HealthTypes, HKSampleType)] = HealthDataUtils.makeFilteredToupleList(from: healthTypeList)
            // For each type, subscribe
            for (index, touple) in filteredTypes.enumerated() {
                
                // Make data fetch query for the current touple value
                let query = self!.subscribeQuery(for: touple, healthStore: healthStore, result: result)
                HealthDataUtils.subscriptionQueries.append(query)
                healthStore.execute(query)
                
                healthStore.enableBackgroundDelivery(for: touple.1, frequency: .immediate, withCompletion: {
                    [weak self] success, error in
                    
                    print("AppleHealth background delivery setup responded")
                    
                    // If fails do nothing
                    if !success || error != nil || self == nil {
                        print("AppleHealth background delivery failed and will exit success: \(success) and error: \(error?.localizedDescription ?? "")")
                        result(false, SimpleLocalizedError("Cant subscribe to Apple Health for type: \(touple.0) and sample type \(touple.1.description)"))
                        abort()
                    }
                    
                    // On last subscribe, call completion
                    if index == (filteredTypes.count - 1) {
                        result(true, nil)
                    }
                })
            }
        })
    }
    
    private func subscribeQuery(for touple: (HealthTypes, HKSampleType), healthStore: HKHealthStore, result: @escaping (Bool, Error?) -> Void) -> HKObserverQuery {
        
        return HKObserverQuery(sampleType: touple.1, predicate: nil) {
            [weak self] query, completionHandler, error in
            
            print("AppleHealth observer query called for touple: \(touple.1.description) and error: \(error?.localizedDescription ?? "")")
            
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the observer. \(error?.localizedDescription ?? "") ***")
                HealthDataUtils.global.sendUpdateEvent(nil, error: error)
                return // abort()
            }
            
            // Fetch the changes
            var hkAnchor = HealthDataUtils.global.getAnchor(anchorKey: touple.1.description)
            if hkAnchor == nil {
                hkAnchor = HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
            }
            
            let onAnchorQueryResults: ((HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void)! = {
                (query: HKAnchoredObjectQuery, addedObjects: [HKSample]?, deletedObjects: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, nsError: Error?) -> Void in
                
                if addedObjects != nil && addedObjects?.count ?? 0 > 0 {
                    print("There were samples for touple: \(touple.1.description)")
                    let data = self?.makeDataList(from: addedObjects, sampleType: touple.1, units: [], healthType: touple.0)
                    HealthDataUtils.global.sendUpdateEvent(data, error: nil)
                }
                
                // NOTE: There's no way to delete values on current api version so it will be ignored for now
                if newAnchor != nil && newAnchor != hkAnchor {
                    HealthDataUtils.global.saveAnchor(anchor: newAnchor!, anchorKey: touple.1.description)
                }
                
                completionHandler()
            }
            let anchoredQuery = HKAnchoredObjectQuery(type: touple.1, predicate: nil, anchor: hkAnchor, limit: HKObjectQueryNoLimit, resultsHandler: onAnchorQueryResults)
            healthStore.execute(anchoredQuery)
        }
    }
    
    // MARK: Statistics
    
    func fetchStatisticsData(for healthType: HealthTypes, params: StatisticsParams, result: @escaping (StatisticsData?, Error?) -> Swift.Void) {
        
        // Note: Here we would check for permissions for reading but apple doesnt grant information about it, only for writing
        guard let sampleType = HealthDataUtils.getHKObjectType(for: healthType) as? HKQuantityType else {
            result(nil, SimpleLocalizedError("Invalid quantity sample type"))
            return
        }
        
        // Use HKQuery to load the most recent samples.
        let timePredicate = HKQuery.predicateForSamples(withStart: params.startDate,
                                                        end: params.endDate,
                                                        options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType,
                                      quantitySamplePredicate: timePredicate,
                                      options: params.statisticsOptions) { [weak self] query, response, error in
            
            if error != nil {
                result(nil, error)
                return
            }
            
            let data = self?.saveAsStatisticsData(response: response, healthType: healthType, params: params)
            result(data, nil)
        }
        
        HealthDataUtils.healthStore?.execute(query)
    }
}
