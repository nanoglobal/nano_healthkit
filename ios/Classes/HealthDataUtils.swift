//
import HealthKit

typealias CharacteristicProcessType = (HKHealthStore) -> Any?

class HealthDataUtils: NSObject {
    
    static let global = HealthDataUtils()
    static var healthStore: HKHealthStore?
    static var subscriptionQueries: [HKObserverQuery] = []
    let dataFetcher = HealthDataFetcher()
    var updateHandler: ((Any?, Error?) -> Void)?
    
    static var WORKOUT_TYPES: [(HKSampleType, HKUnit?, HKUnit?)] = []
    static var CATEGORY_TYPES: [HKCategoryTypeIdentifier] = []
    static var QUANTITY_TYPES: [(HKQuantityTypeIdentifier, HKUnit?)] = []
    static var CHARACTERISTIC_TYPES: [(HKCharacteristicTypeIdentifier, CharacteristicProcessType)] = []
    static var CLINICAL_TYPES: [Any] = []
    static var DOCUMENT_TYPES: [HKDocumentTypeIdentifier] = []
    static var CORRELATION_TYPES: [(HKCorrelationTypeIdentifier, [HKUnit])] = []
    static var STATISTICS_OPTIONS_MAP: NSMutableDictionary = [:]
    
    override init() {
        super.init()
        
        // Add version specific types
        fillReadTypes()
        fillWriteTypes()
        // Create the instance of healthStore
        if HKHealthStore.isHealthDataAvailable() && HealthDataUtils.healthStore == nil {
            HealthDataUtils.healthStore = HKHealthStore()
        }
    }
    
    func requestReadPermissions( readList: HealthTypeList?, writeList: HealthTypeList?, result: @escaping (Bool, Error?) -> Void) {
        guard let readList = readList else{
             result(false, SimpleLocalizedError("Invalid list of params"))
            return
        }
    
        let readFilteredList = HealthDataUtils.filterPermissionRequiredTypes(readList)
        let readSet = HealthDataUtils.makeHKObjectSet(from: readFilteredList)

        HealthDataUtils.healthStore?.requestAuthorization(toShare: nil, read: readSet) { success, error in
            result(success, error)
        }
    }
    func requestWritePermissions( writeList: HealthTypeList?, result: @escaping (Bool, Error?) -> Void) {
          guard let writeList = writeList else{
               result(false, SimpleLocalizedError("Invalid list of params"))
              return
          }

          let writeFilteredList = HealthDataUtils.filterWriteExistingTypes(writeList)
          let writeSet = HealthDataUtils.makeHKSampleSet(from: writeFilteredList)

          HealthDataUtils.healthStore?.requestAuthorization(toShare: writeSet, read: nil) { success, error in
              result(success, error)
          }
      }
    
    func fetchBatchData(for requestList: HealthDataRequestList?, result: @escaping (HealthDataList?, Error?) -> Void) {
        
        guard let requestList = requestList else {
            result(nil, SimpleLocalizedError("Invalid request"))
            return
        }
        
        let group = DispatchGroup()
        var groupError: Error?
        var groupResult = HealthDataList()
        for healthRequest in requestList.requests {
            
            // Exit the loop
            if groupError != nil {
                break
            }
            // Fetch
            group.enter()
            fetchData(for: healthRequest, result: { batch, error in
                groupError = error
                groupResult.data.append(contentsOf: batch?.data ?? [])
                group.leave() // Continues the loop
            })
        }
        
        // Return result
        group.notify(queue: .main) {
            result(groupResult, groupError)
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
    
    func writeData(for healthData: HealthData?, result: @escaping (Bool, Error?) -> Void){
        guard let data = healthData else {
             result(false, SimpleLocalizedError("Invalid request"))
             return
         }
        
        guard let healthDataHKObject = HealthDataUtils.makeHKObject(for: data) else {
            result(false, SimpleLocalizedError("Invalid request"))
            return
        }
        
        HealthDataUtils.healthStore?.save(healthDataHKObject, withCompletion: { success, error in
            result(success, error)
        })
        
    }
    
    private func parseHealthRequest(_ request: HealthDataRequest) -> HealthDataFetcher.BatchParams {
        
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        let limit = request.limit <= 0 ? HKObjectQueryNoLimit : Int(request.limit)
        let sortKey = request.sorting == .ascendingStartDate || request.sorting == .descendingStartDate ? HKSampleSortIdentifierStartDate : HKSampleSortIdentifierEndDate
        let sortAscending = request.sorting == .ascendingStartDate || request.sorting == .ascendingEndDate
        let sort = NSSortDescriptor(key: sortKey, ascending: sortAscending)
        let units: [HKUnit] = request.units.map { HKUnit(from: $0) }
        return HealthDataFetcher.BatchParams(startDate: startDate, endDate: endDate, limit: limit, sort: sort, units: units)
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
    
    func filterReadExistingTypes(for list: HealthTypeList?, result: @escaping (HealthTypeList?, Error?) -> Void) {
        
        guard let list = list else {
            result(nil, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        let filteredList = HealthDataUtils.filterReadExistingTypes(list)
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
    
    
    func filterWriteExistingTypes(for list: HealthTypeList?, result: @escaping (HealthTypeList?, Error?) -> Void) {
        
        guard let list = list else {
            result(nil, SimpleLocalizedError("Invalid list of params"))
            return
        }
        
        let filteredList = HealthDataUtils.filterWriteExistingTypes(list)
        result(filteredList, nil)
    }
}
