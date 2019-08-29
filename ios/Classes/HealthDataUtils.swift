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
    static var CHARACTERISTIC_TYPES: [(HKCharacteristicTypeIdentifier, (HKHealthStore) -> Any?)] = []
    
    override init() {
        super.init()
        
        // Add version specific types
        fillTypes()
        
        // Create the instance of healthStore
        if HKHealthStore.isHealthDataAvailable() && HealthDataUtils.healthStore == nil {
            HealthDataUtils.healthStore = HKHealthStore()
        }
    }
    
    func requestPermissions(for list: HealthTypeList?, result: @escaping (Bool, Error?) -> Void) {
        
        guard let list = list else {
            result(false, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        let typeSet = HealthDataUtils.makeSampleSet(from: list)
        HealthDataUtils.healthStore?.requestAuthorization(toShare: nil, read: typeSet) { success, error in
            result(success, error)
        }
    }
    
    func fetchData(for request: HealthDataRequest?, result: @escaping (HealthDataList?, Error?) -> Void) {
        
        guard let request = request else {
            result(nil, SimpleLocalizedError("Invalid request"))
            return
        }
        
        guard let index = HealthDataUtils.getTypeIndex(request.type) else {
            result(nil, SimpleLocalizedError("Requested type is not available"))
            return
        }
        
        // Characteristics
        if index.1 == .characteristic {
            dataFetcher.fetchCharacteristicData(for: request.type, healthStore: HealthDataUtils.healthStore!, result: result)
            return
        }
        
        // Other types
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        let limit = request.limit <= 0 ? HKObjectQueryNoLimit : Int(request.limit)
        dataFetcher.fetchBatchData(for: request.type, startDate: startDate, endDate: endDate, limit: limit, result: result)
    }
    
    func filterExistingTypes(for list: HealthTypeList?, result: @escaping (HealthTypeList?, Error?) -> Void) {
        
        guard let list = list else {
            result(nil, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        var filteredList = HealthTypeList()
        for elem in list.types {
            if HealthDataUtils.typeExists(elem) {
                filteredList.types.append(elem)
            }
        }
        result(filteredList, nil)
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
