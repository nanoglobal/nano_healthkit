//
import HealthKit

class HealthDataFetcher: NSObject {
    
    // MARK: Data fetching
    
    func fetchBatchData(for healthType: HealthTypes, startDate: Date, endDate: Date, limit: Int, result: @escaping (HealthDataList?, Error?) -> Swift.Void) {
        
        // Note: Here we would check for permissions for reading but apple doesnt grant information about it, only for writing
        guard let sampleType = HealthDataUtils.getSampleType(for: healthType) as? HKSampleType else {
            result(nil, SimpleLocalizedError("Invalid sample type"))
            return
        }
        
        // Use HKQuery to load the most recent samples.
        let timePredicate = HKQuery.predicateForSamples(withStart: startDate,
                                                        end: endDate,
                                                        options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: timePredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { [weak self] query, samples, error in
            
            if error != nil {
                result(nil, error)
                return
            }
            
            let data = self?.makeData(from: samples, sampleType: sampleType, healthType: healthType)
            result(data, nil)
        }
        
        HealthDataUtils.healthStore?.execute(sampleQuery)
    }
    
    func fetchCharacteristicData(for healthType: HealthTypes, healthStore: HKHealthStore, result: @escaping (HealthDataList?, Error?) -> Swift.Void) {
        
        guard let index = HealthDataUtils.getTypeIndex(healthType),
            let characteristicType = HealthDataUtils.getSampleType(for: healthType) as? HKCharacteristicType else {
            result(nil, SimpleLocalizedError("Invalid sample type"))
            return
        }
        
        let characteristic = HealthDataUtils.CHARACTERISTIC_TYPES[index.0]
        let evaluatedValue = characteristic.1(healthStore)
        let data = makeData(from: evaluatedValue, characteristicType: characteristicType, healthType: healthType)
        result(data, nil)
    }
    
    // MARK: Subscriptions
     
     func unsubscribeToUpdates(completion: @escaping (Bool, Error?) -> Void) {
         HealthDataUtils.healthStore?.disableAllBackgroundDelivery(completion: completion)
     }
     
     func subscribeToUpdates(completion: @escaping (Bool, Error?) -> Void) {
     
         // First unsubscribe, once finished subscribe
         unsubscribeToUpdates(completion: { success, error in
     
             // If service is not active, exit
             // if !(self.sharedMemory.appleHealthRecord?.serviceIsActive ?? false) {
             //    completion(false, SimpleLocalizedError("applehealth_cant_subscribe"))
             //    return
             // }
     
             // Subscribe
             self.subscribeToAllSampleTypes(completion: completion)
         })
     }
     
     private func subscribeToAllSampleTypes(completion: @escaping (Bool, Error?) -> Void) {
     
         // Make an all types set that
         let allTypes = HealthDataUtils.getAllSampleTypes()
     
         // For each type, subscribe
         for (index, touple) in allTypes.enumerated() {
     
             HealthDataUtils.healthStore?.enableBackgroundDelivery(for: touple.0, frequency: .immediate, withCompletion: {
                 [weak self] success, error in
     
                 print("AppleHealth background delivery setup responded")
     
                 // If fails do nothing
                 if !success || error != nil || self == nil {
                     print("AppleHealth background delivery failed and will exit success: \(success) and error: \(error?.localizedDescription ?? "")")
                     completion(false, SimpleLocalizedError("applehealth_cant_subscribe"))
                     abort()
                 }
     
                 let query = self!.subscribeQuery(for: touple, completion: completion)
                 HealthDataUtils.healthStore?.execute(query)
     
                 // On last subscribe, call completion
                 if index == (allTypes.count - 1) {
                     completion(true, nil)
                 }
             })
         }
     }
     
     private func subscribeQuery(for touple: (HKSampleType, HealthKitFetchTypes, Int), completion: @escaping (Bool, Error?) -> Void) -> HKObserverQuery {
     
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
                     // let data = self?.makeData(from: addedObjects, fetchType: touple.1, index: touple.2, sampleType: touple.0)
                     // self?.sendData(data?.data) //TODO: Send data
                 }
     
                 // NOTE: There's no way to delete values on current api version so it will be ignored for now
     
                 // TODO: check this
                 if newAnchor != nil && newAnchor != hkAnchor {
                     self?.saveAnchor(anchor: newAnchor!, anchorKey: touple.0.description)
                 }
     
                 completionHandler()
             }
             let anchoredQuery = HKAnchoredObjectQuery(type: touple.0, predicate: nil, anchor: hkAnchor, limit: HKObjectQueryNoLimit, resultsHandler: onAnchorQueryResults)
             HealthDataUtils.healthStore?.execute(anchoredQuery)
         }
     }
}
