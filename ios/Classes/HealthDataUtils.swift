//
import HealthKit
import HealthKitUI

class HealthDataUtils: NSObject {
    
    static let global = HealthDataUtils()
    static var healthStore: HKHealthStore?
    
    var statusRecord: HealthStatusRecord? = HealthStatusRecord()
    
    let dataFetcher = HealthDataFetcher()
    
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
    
    // Note: Dont change the order
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
    
    func fillTypes() {
        // TODO: MAKE ME with iOS version specific code
    }
    
    static var TYPE_INDEXES: [HealthTypes: Int] = [
        .workoutMain: 0,
        .categorySleepAnalysis: 0,
        .categoryAppleStandHour: 1,
        .categoryCervicalMucusQuality: 2,
        .quantityBodyMassIndex: 0,
        .quantityBodyFatPercentage: 1,
        .quantityHeight: 2,
    ]
    
    static func getSampleType(for healthType: HealthTypes) -> HKSampleType? {
        
        let index = TYPE_INDEXES[healthType]!
        if healthType.rawValue <= HealthTypes.workoutMain.rawValue {
            return HealthDataUtils.WORKOUT_TYPES[index]
        } else if healthType.rawValue >= HealthTypes.quantityBodyMassIndex.rawValue {
            return getQuantityType(index)
        } else {
            return getCategoryType(index)
        }
    }
    
    override init() {
        super.init()
        
        // Add version specific types
        fillTypes()
        
        // Create the instance of healthStore
        if HKHealthStore.isHealthDataAvailable() && HealthDataUtils.healthStore == nil {
            HealthDataUtils.healthStore = HKHealthStore()
        }
    }
    
    func requestPermissions(for list: HealthTypeList, completion: @escaping (Bool, Error?) -> Void) {
        
        let typeSet = HealthDataUtils.makeSampleSet(from: list)
        HealthDataUtils.healthStore?.requestAuthorization(toShare: nil, read: typeSet) { success, error in
            completion(success, error)
        }
    }
    
    func fetchData(request: HealthDataRequest, result: @escaping (HealthDataList?, Error?) -> Void) {
        
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
    
    // MARK: Type manupulation
    
    private static func getCategoryType(_ index: Int) -> HKSampleType? {
        
        // It could be false if the requested type is not available for a given iOS version
        if HealthDataUtils.CATEGORY_TYPES.count < index {
            return nil
        }
        let identifier = HealthDataUtils.CATEGORY_TYPES[index]
        return HKObjectType.categoryType(forIdentifier: identifier)
    }
    
    private static func getQuantityType(_ index: Int) -> HKSampleType? {
        
        // It could be false if the requested type is not available for a given iOS version
        if HealthDataUtils.QUANTITY_TYPES.count < index {
            return nil
        }
        let identifier = HealthDataUtils.QUANTITY_TYPES[index].0
        return HKObjectType.quantityType(forIdentifier: identifier)
    }
    
    private static func makeSampleSet(from list: HealthTypeList) -> Set<HKSampleType> {
        
        return Set(list.types.map { (helthType) -> HKSampleType? in
            HealthDataUtils.getSampleType(for: helthType)
        }.compactMap { $0 })
    }
}
