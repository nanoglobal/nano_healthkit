//
import HealthKit

class HealthDataUtils: NSObject {
    
    static let global = HealthDataUtils()
    static var healthStore: HKHealthStore?
    let dataFetcher = HealthDataFetcher()
    
    var statusRecord: HealthStatusRecord? = HealthStatusRecord()
    
    static var WORKOUT_TYPES: [HKSampleType] = []
    static var CATEGORY_TYPES: [HKCategoryTypeIdentifier] = []
    static var QUANTITY_TYPES: [(HKQuantityTypeIdentifier, HKUnit?)] = []
    static var CHARACTERISTIC_TYPES: [HKCharacteristicTypeIdentifier] = []
    
    override init() {
        super.init()
        
        // Add version specific types
        fillTypes()
        
        // Create the instance of healthStore
        if HKHealthStore.isHealthDataAvailable() && HealthDataUtils.healthStore == nil {
            HealthDataUtils.healthStore = HKHealthStore()
        }
    }
    
    func requestPermissions(for list: HealthTypeList?, completion: @escaping (Bool, Error?) -> Void) {
        
        guard let list = list else {
            completion(false, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        let typeSet = HealthDataUtils.makeSampleSet(from: list)
        HealthDataUtils.healthStore?.requestAuthorization(toShare: nil, read: typeSet) { success, error in
            completion(success, error)
        }
    }
    
    func fetchData(request: HealthDataRequest?, result: @escaping (HealthDataList?, Error?) -> Void) {
        
        guard let request = request else {
            result(nil, SimpleLocalizedError("Invalid request"))
            return
        }
        
        let index = HealthDataUtils.TYPE_INDEXES[request.type]
        if (index?.1 == .characteristic) {
            dataFetcher.fetchCharacteristicData(for: request.type, healthStore: healthStore, result: result)
            return
        }
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        dataFetcher.fetchBatchData(for: request.type, startDate: startDate, endDate: endDate, result: result)
    }
    
    // MARK: - Not yet used methods
    
    /* func subscribeToUpdates(forced: Bool, completion: @escaping (Bool, Error?) -> Void) {
     
         dataFetcher.subscribeToUpdates(completion: completion)
     }
     
     private func fetchAllHistoricData(completion: @escaping (Bool, Error?) -> Void) {
     
         // dataFetcher.fetchAllHistoricData(record: statusRecord!, completion: completion)
     }
     
     func connectToAppleHealth(permissionCompletion: @escaping (Bool, Error?) -> Void,
                               subscribeCompletion: @escaping (Bool, Error?) -> Void) {
     
         requestPermissions { [weak self] success, error in
     
             permissionCompletion(success, error)
     
             if error == nil {
     
                 // Subscribe to updates
                 self?.subscribeToUpdates(forced: true) { success, error in
     
                     subscribeCompletion(success, error)
                     if error != nil {
                         self?.disconnectToAppleHealth()
                         abort()
                     }
                 }
     
                 // Fetch all historic data
                 self?.fetchAllHistoricData { success, error in
     
                     // self?.callSendingService()
                     if error != nil {
                         self?.disconnectToAppleHealth()
                         abort()
                     }
                 }
             }
         }
     }
     
     func disconnectToAppleHealth() {
     
         if statusRecord != nil {
             statusRecord?.serviceIsActive = false
             HealthDataUtils.saveRecord(statusRecord!)
         }
     
         // NOTE: Fetcher will stop as soon as the service is inactive
     
         // Remove subscription
         dataFetcher.unsubscribeToUpdates()
     }
     
     func isConnectedToAppleHealth() -> Bool {
         return statusRecord?.serviceIsActive ?? false
     } */
}
