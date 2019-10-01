//
import HealthKit

typealias CharacteristicProcessType = (HKHealthStore) -> Any?

class HealthDataUtils: NSObject {
    
    static let global = HealthDataUtils()
    static var healthStore: HKHealthStore?
    static var subscriptionQueries: [HKObserverQuery] = []
    let dataFetcher = HealthDataFetcher()
    var updateHandler: ((Any?, Error?) -> Void)?
    
    var statusRecord: HealthStatusRecord? = HealthStatusRecord()
    
    static var WORKOUT_TYPES: [HKSampleType] = []
    static var CATEGORY_TYPES: [HKCategoryTypeIdentifier] = []
    static var QUANTITY_TYPES: [(HKQuantityTypeIdentifier, HKUnit?)] = []
    static var CHARACTERISTIC_TYPES: [(HKCharacteristicTypeIdentifier, CharacteristicProcessType)] = []
    static var CLINICAL_TYPES: [Any] = []
    static var DOCUMENT_TYPES: [HKDocumentTypeIdentifier] = []
    static var CORRELATION_TYPES: [HKCorrelationTypeIdentifier] = []
    static var STATISTICS_OPTIONS_MAP: NSMutableDictionary = [:]
    
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
        
        let filteredList = HealthDataUtils.filterPermissionRequiredTypes(list)
        let typeSet = HealthDataUtils.makeHKObjectSet(from: filteredList)
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
        dataFetcher.fetchBatchData(for: request.type, params: parseHealthRequest(request), result: result)
    }
    
    func fetchStatisticsData(for request: StatisticsRequest?, result: @escaping (StatisticsData?, Error?) -> Void) {
        
        guard let request = request else {
            result(nil, SimpleLocalizedError("Invalid request"))
            return
        }
        
        guard let index = HealthDataUtils.getTypeIndex(request.type) else {
            result(nil, SimpleLocalizedError("Requested type is not available"))
            return
        }
        
        // Only can do statistics of quantity types
        if index.1 != .quantity {
            result(nil, SimpleLocalizedError("Only valid types are quantity types"))
            return
        }
        
        // Other types
        dataFetcher.fetchStatisticsData(for: request.type, params: parseStatisticsRequest(request), result: result)
    }
    
    private func parseHealthRequest(_ request: HealthDataRequest) -> HealthDataFetcher.BatchParams {
        
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        let limit = request.limit <= 0 ? HKObjectQueryNoLimit : Int(request.limit)
        let sortKey = request.sorting == .ascendingStartDate || request.sorting == .descendingStartDate ? HKSampleSortIdentifierStartDate : HKSampleSortIdentifierEndDate
        let sortAscending = request.sorting == .ascendingStartDate || request.sorting == .ascendingEndDate
        let sort = NSSortDescriptor(key: sortKey, ascending: sortAscending)
        return HealthDataFetcher.BatchParams(startDate: startDate, endDate: endDate, limit: limit, sort: sort)
    }
    
    private func parseStatisticsRequest(_ request: StatisticsRequest) -> HealthDataFetcher.StatisticsParams {
        
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        var options: HKStatisticsOptions = []
        for ownOption in request.options {
            if let option = HealthDataUtils.STATISTICS_OPTIONS_MAP[ownOption] as? HKStatisticsOptions.Element {
                options.insert(option)
            }
        }
        return HealthDataFetcher.StatisticsParams(startDate: startDate, endDate: endDate, statisticsOptions: options)
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
