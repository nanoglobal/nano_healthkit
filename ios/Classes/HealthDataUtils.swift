//
import HealthKit

class HealthDataUtils: NSObject {
    
    static let global = HealthDataUtils()
    static var healthStore: HKHealthStore?
    let dataFetcher = HealthDataFetcher()
    var updateHandler: ((Any?, Error?) -> Void)?
    
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
        
        let typeSet = HealthDataUtils.makeHKObjectSet(from: list)
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
        
        let filteredList = HealthDataUtils.filterExistingTypes(list)
        result(filteredList, nil)
    }
    
    func subscribeToUpdates(for list: HealthTypeList?, updateHandler: @escaping (Any?, Error?) -> Void, result: @escaping (Bool, Error?) -> Void) {
        
        self.updateHandler = updateHandler
        guard let list = list else {
            result(false, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        dataFetcher.subscribeToUpdates(for: list, healthStore: HealthDataUtils.healthStore!, result: result)
    }
    
    func unsubscribeToUpdates(result: @escaping (Bool, Error?) -> Void) {
        
        self.updateHandler = nil
        dataFetcher.unsubscribeToUpdates(result: result)
    }
    
    func sendUpdateEvent(_ dataList: HealthDataList?, error: Error?) {
        
        self.updateHandler?(dataList, error)
    }
}
