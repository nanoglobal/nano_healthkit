//
import HealthKit
import HealthKitUI

class AppleHealthUtils: NSObject {
    
    static let global = AppleHealthUtils()
    static var healthStore: HKHealthStore?
    
    var statusRecord: AppleHealthStatusRecord?
    
    let dataFetcher = AppleHealthDataFetcher()
    
    static var CATEGORY_TYPES: [HKCategoryTypeIdentifier] = [
        .sleepAnalysis,
        .appleStandHour,
        .cervicalMucusQuality,
        .ovulationTestResult,
        .menstrualFlow,
        .intermenstrualBleeding,
        .sexualActivity,
        .mindfulSession,
    ]
    
    static var QUANTITY_TYPES: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.bodyMassIndex, nil),
        (.bodyFatPercentage, .percent()),
        (.height, .meter()),
        (.bodyMass, .gram()),
        (.leanBodyMass, .gram()),
        (.waistCircumference, .meter()),
        // Fitness
        (.stepCount, .count()),
        (.distanceWalkingRunning, .meter()),
        (.distanceCycling, .meter()),
        (.distanceWheelchair, .meter()),
        (.basalEnergyBurned, .joule()),
        (.activeEnergyBurned, .joule()),
        (.flightsClimbed, .count()),
        (.nikeFuel, .count()),
        (.appleExerciseTime, .second()),
        (.pushCount, .count()),
        (.distanceSwimming, .meter()),
        (.swimmingStrokeCount, .count()),
        (.vo2Max, HKUnit(from: "ml/kg*min")), // ml/(kg*min)
        (.distanceDownhillSnowSports, .meter()),
        // Vitals
        (.heartRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        (.bodyTemperature, .degreeCelsius()),
        (.basalBodyTemperature, .degreeCelsius()),
        (.bloodPressureSystolic, .atmosphere()),
        (.bloodPressureDiastolic, .atmosphere()),
        (.respiratoryRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // Beats per minute estimate of a user's lowest heart rate while at rest
        (.restingHeartRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // Average heartbeats per minute captured by an Apple Watch while a user is walking
        (.walkingHeartRateAverage, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // The standard deviation of heart beat-to-beat intevals (Standard Deviation of Normal to Normal)
        (.heartRateVariabilitySDNN, HKUnit(from: "ms")), // Time (ms)
        // Results
        (.oxygenSaturation, .percent()),
        (.peripheralPerfusionIndex, .percent()),
        (.bloodGlucose, HKUnit(from: "g/l")), // Mass/Volume
        (.numberOfTimesFallen, .count()),
        (.electrodermalActivity, .siemen()),
        (.inhalerUsage, .count()),
        (.insulinDelivery, .internationalUnit()),
        (.bloodAlcoholContent, .percent()),
        (.forcedVitalCapacity, .liter()),
        (.forcedExpiratoryVolume1, .liter()),
        (.peakExpiratoryFlowRate, HKUnit(from: "l/s")), // Volume/Time
        // Nutrition
        (.dietaryFatTotal, .gram()),
        (.dietaryFatPolyunsaturated, .gram()),
        (.dietaryFatMonounsaturated, .gram()),
        (.dietaryFatSaturated, .gram()),
        (.dietaryCholesterol, .gram()),
        (.dietarySodium, .gram()),
        (.dietaryCarbohydrates, .gram()),
        (.dietaryFiber, .gram()),
        (.dietarySugar, .gram()),
        (.dietaryEnergyConsumed, .joule()),
        (.dietaryProtein, .gram()),
        (.dietaryVitaminA, .gram()),
        (.dietaryVitaminB6, .gram()),
        (.dietaryVitaminB12, .gram()),
        (.dietaryVitaminC, .gram()),
        (.dietaryVitaminD, .gram()),
        (.dietaryVitaminE, .gram()),
        (.dietaryVitaminK, .gram()),
        (.dietaryCalcium, .gram()),
        (.dietaryIron, .gram()),
        (.dietaryThiamin, .gram()),
        (.dietaryRiboflavin, .gram()),
        (.dietaryNiacin, .gram()),
        (.dietaryFolate, .gram()),
        (.dietaryBiotin, .gram()),
        (.dietaryPantothenicAcid, .gram()),
        (.dietaryPhosphorus, .gram()),
        (.dietaryIodine, .gram()),
        (.dietaryMagnesium, .gram()),
        (.dietaryZinc, .gram()),
        (.dietarySelenium, .gram()),
        (.dietaryCopper, .gram()),
        (.dietaryManganese, .gram()),
        (.dietaryChromium, .gram()),
        (.dietaryMolybdenum, .gram()),
        (.dietaryChloride, .gram()),
        (.dietaryPotassium, .gram()),
        (.dietaryCaffeine, .gram()),
        (.dietaryWater, .liter()),
        (.uvExposure, .count()),
    ]
    
    static var WORKOUT_TYPES: [HKSampleType] = [
        HKObjectType.workoutType(),
    ]
    
    static var ALL_TYPES: [[Any]] = [CATEGORY_TYPES, QUANTITY_TYPES, WORKOUT_TYPES]
    
    override init() {
        super.init()
        
        // Init everything including creating AppleHealthRecord
        createRecordIfNone()
        
        // Create the instance of healthStore
        if HKHealthStore.isHealthDataAvailable() && AppleHealthUtils.healthStore == nil {
            AppleHealthUtils.healthStore = HKHealthStore()
        }
    }
    
    static func getAllSampleTypes() -> [(HKSampleType, HealthKitFetchTypes, Int)] {
        
        var allTypes: [(HKSampleType, HealthKitFetchTypes, Int)] = []
        for typeIndex in 0 ..< AppleHealthUtils.ALL_TYPES.count {
            let fetchType = HealthKitFetchTypes(rawValue: typeIndex)!
            let typeArray = AppleHealthUtils.ALL_TYPES[typeIndex]
            for index in 0 ..< typeArray.count {
                if let sampleType = AppleHealthUtils.getObjectType(for: fetchType, index: index) {
                    let touple = (sampleType, fetchType, index)
                    allTypes.append(touple)
                }
            }
        }
        return allTypes
    }
    
    static func getSimpleAllSampleTypes(origin: [(HKSampleType, HealthKitFetchTypes, Int)]) -> Set<HKSampleType> {
        
        var allTypes: Set<HKSampleType> = Set()
        for touple in origin {
            allTypes.insert(touple.0)
        }
        return allTypes
    }
    
    static func getObjectType(for fetchType: HealthKitFetchTypes, index: Int) -> HKSampleType? {
        
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
    
    func requestPermissions(completion: @escaping (Bool, Error?) -> Void) {
        
        // Make an all types set that
        let allTypes = AppleHealthUtils.getSimpleAllSampleTypes(origin: AppleHealthUtils.getAllSampleTypes())
        
        AppleHealthUtils.healthStore?.requestAuthorization(toShare: nil, read: allTypes) { success, error in
            completion(success, error)
        }
    }
    
    func fetchData(request: HealthKitDataBatchRequest, result: @escaping (HealthKitDataBatch?, Error?) -> Void) {
        
        let startDate = request.startDate.isEmpty ? Date.distantPast : Date(iso8601: request.startDate)
        let endDate = request.endDate.isEmpty ? Date() : Date(iso8601: request.endDate)
        dataFetcher.fetchBatchData(for: request.type, index: Int(request.index), startDate: startDate, endDate: endDate, result: result)
    }
    
    // MARK: - Not yet used methods
    
    func subscribeToUpdates(forced: Bool, completion: @escaping (Bool, Error?) -> Void) {
        
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
            AppleHealthUtils.saveRecord(statusRecord!)
        }
        
        // NOTE: Fetcher will stop as soon as the service is inactive
        
        // Remove subscription
        dataFetcher.unsubscribeToUpdates()
    }
    
    func isConnectedToAppleHealth() -> Bool {
        return statusRecord?.serviceIsActive ?? false
    }
    
    // MARK: Aux methods
    
    func createRecordIfNone() {
        
        if statusRecord == nil {
            statusRecord = AppleHealthStatusRecord()
            AppleHealthUtils.saveRecord(statusRecord!)
        }
    }
    
    static func saveRecord(_ record: AppleHealthStatusRecord?) {
        // SharedMemory.global.appleHealthRecord = record
        // TODO: Send the record to the caller
    }
}

class AppleHealthStatusRecord {
    
    var serviceIsActive = false
    var readAllHasCompleted: Bool = false
    var readType: Int = 0
    var readIndex: Int = 0
}
