//
import HealthKit

extension HealthDataUtils {
    
    static var WORKOUT_TYPES_V8_0: [HKSampleType] = [
        HKObjectType.workoutType(),
    ]
    
    static var CATEGORY_TYPES_V8_0: [HKCategoryTypeIdentifier] = [
        .sleepAnalysis,
        .appleStandHour,
        .cervicalMucusQuality,
        .ovulationTestResult,
        .menstrualFlow,
        .intermenstrualBleeding,
        .sexualActivity,
    ]
    
    @available(iOS 10.0, *)
    static var CATEGORY_TYPES_V10_0: [HKCategoryTypeIdentifier] = [
        .mindfulSession,
    ]
    
    @available(iOS 12.2, *)
    static var CATEGORY_TYPES_V12_2: [HKCategoryTypeIdentifier] = [
        .highHeartRateEvent,
        .lowHeartRateEvent,
        .irregularHeartRhythmEvent,
    ]
    
    // Note: Dont change the order
    static var QUANTITY_TYPES_V8_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.bodyMassIndex, nil),
        (.bodyFatPercentage, .percent()),
        (.height, .meter()),
        (.bodyMass, .gram()),
        (.leanBodyMass, .gram()),
        // Fitness
        (.stepCount, .count()),
        (.distanceWalkingRunning, .meter()),
        (.distanceCycling, .meter()),
        (.basalEnergyBurned, .joule()),
        (.activeEnergyBurned, .joule()),
        (.flightsClimbed, .count()),
        (.nikeFuel, .count()),
        // Vitals
        (.heartRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        (.bodyTemperature, .degreeCelsius()),
        (.basalBodyTemperature, .degreeCelsius()),
        (.bloodPressureSystolic, .atmosphere()),
        (.bloodPressureDiastolic, .atmosphere()),
        (.respiratoryRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // Results
        (.oxygenSaturation, .percent()),
        (.peripheralPerfusionIndex, .percent()),
        (.bloodGlucose, HKUnit(from: "g/l")), // Mass/Volume
        (.numberOfTimesFallen, .count()),
        (.electrodermalActivity, .siemen()),
        (.inhalerUsage, .count()),
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
    
    @available(iOS 9.3, *)
    static var QUANTITY_TYPES_V9_3: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.appleExerciseTime, .second()),
    ]
    
    @available(iOS 10.0, *)
    static var QUANTITY_TYPES_V10_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.distanceWheelchair, .meter()),
        (.pushCount, .count()),
        (.distanceSwimming, .meter()),
        (.swimmingStrokeCount, .count()),
    ]
    
    @available(iOS 11.0, *)
    static var QUANTITY_TYPES_V11_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.waistCircumference, .meter()),
        (.vo2Max, HKUnit(from: "ml/kg*min")), // ml/(kg*min)
        // Beats per minute estimate of a user's lowest heart rate while at rest
        (.restingHeartRate, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // Average heartbeats per minute captured by an Apple Watch while a user is walking
        (.walkingHeartRateAverage, HKUnit(from: "count/s")), // Scalar(Count)/Time
        // The standard deviation of heart beat-to-beat intevals (Standard Deviation of Normal to Normal)
        (.heartRateVariabilitySDNN, HKUnit(from: "ms")), // Time (ms)
        (.insulinDelivery, .internationalUnit()),
    ]
    
    @available(iOS 11.2, *)
    static var QUANTITY_TYPES_V11_2: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.distanceDownhillSnowSports, .meter()),
    ]
    
    static var TYPE_INDEXES: [HealthTypes: Int] = [
        .workoutMain: 0,
        .categorySleepAnalysis: 0,
        .categoryAppleStandHour: 1,
        .categoryCervicalMucusQuality: 2,
        .categoryOvulationTestResult: 3,
        .categoryMenstrualFlow: 4,
        .categoryIntermenstrualBleeding: 5,
        .categorySexualActivity: 6,
        .categoryMindfulSession: 7,
        .categoryHighHeartRateEvent: 8,
        .categoryLowHeartRateEvent: 9,
        .categoryIrregularHeartRhythmEvent: 10,
        .quantityBodyMassIndex: 0,
        .quantityBodyFatPercentage: 1,
        .quantityHeight: 2,
        .quantityBodyMass: 3,
        .quantityLeanBodyMass: 4,
        .quantityStepCount: 5,
        .quantityDistanceWalkingRunning: 6,
        .quantityDistanceCycling: 7,
        .quantityBasalEnergyBurned: 8,
        .quantityActiveEnergyBurned: 9,
        .quantityFlightsClimbed: 10,
        .quantityNikeFuel: 11,
        .quantityHeartRate: 12,
        .quantityBodyTemperature: 13,
        .quantityBasalBodyTemperature: 14,
        .quantityBloodPressureSystolic: 15,
        .quantityBloodPressureDiastolic: 16,
        .quantityRespiratoryRate: 17,
        .quantityOxygenSaturation: 18,
        .quantityPeripheralPerfusionIndex: 19,
        .quantityBloodGlucose: 20,
        .quantityNumberOfTimesFallen: 21,
        .quantityElectrodermalActivity: 22,
        .quantityInhalerUsage: 23,
        .quantityBloodAlcoholContent: 24,
        .quantityForcedVitalCapacity: 25,
        .quantityForcedExpiratoryVolume1: 26,
        .quantityPeakExpiratoryFlowRate: 27,
        .quantityDietaryFatTotal: 28,
        .quantityDietaryFatPolyunsaturated: 29,
        .quantityDietaryFatMonounsaturated: 30,
        .quantityDietaryFatSaturated: 31,
        .quantityDietaryCholesterol: 32,
        .quantityDietarySodium: 33,
        .quantityDietaryCarbohydrates: 34,
        .quantityDietaryFiber: 35,
        .quantityDietarySugar: 36,
        .quantityDietaryEnergyConsumed: 37,
        .quantityDietaryProtein: 38,
        .quantityDietaryVitaminA: 39,
        .quantityDietaryVitaminB6: 40,
        .quantityDietaryVitaminB12: 41,
        .quantityDietaryVitaminC: 42,
        .quantityDietaryVitaminD: 43,
        .quantityDietaryVitaminE: 44,
        .quantityDietaryVitaminK: 45,
        .quantityDietaryCalcium: 46,
        .quantityDietaryIron: 47,
        .quantityDietaryThiamin: 48,
        .quantityDietaryRiboflavin: 49,
        .quantityDietaryNiacin: 50,
        .quantityDietaryFolate: 51,
        .quantityDietaryBiotin: 52,
        .quantityDietaryPantothenicAcid: 53,
        .quantityDietaryPhosphorus: 54,
        .quantityDietaryIodine: 55,
        .quantityDietaryMagnesium: 56,
        .quantityDietaryZinc: 57,
        .quantityDietarySelenium: 58,
        .quantityDietaryCopper: 59,
        .quantityDietaryManganese: 60,
        .quantityDietaryChromium: 61,
        .quantityDietaryMolybdenum: 62,
        .quantityDietaryChloride: 63,
        .quantityDietaryPotassium: 64,
        .quantityDietaryCaffeine: 65,
        .quantityDietaryWater: 66,
        .quantityUvExposure: 67,
        .quantityAppleExerciseTime: 68,
        .quantityDistanceWheelchair: 69,
        .quantityPushCount: 70,
        .quantityDistanceSwimming: 71,
        .quantitySwimmingStrokeCount: 72,
        .quantityWaistCircumference: 73,
        .quantityVo2Max: 74,
        .quantityRestingHeartRate: 75,
        .quantityWalkingHeartRateAverage: 76,
        .quantityHeartRateVariabilitySdnn: 77,
        .quantityInsulinDelivery: 78,
        .quantityDistanceDownhillSnowSports: 79,
    ]
    
    func fillTypes() {
        
        if #available(iOS 8.0, *) {
            HealthDataUtils.WORKOUT_TYPES.append(contentsOf: HealthDataUtils.WORKOUT_TYPES_V8_0)
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V8_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V8_0)
        }
        
        if #available(iOS 9.3, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V9_3)
        }
        
        if #available(iOS 10.0, *) {
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V10_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V10_0)
        }
        
        if #available(iOS 11.0, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V11_0)
        }
        
        if #available(iOS 11.2, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V11_2)
        }
        
        if #available(iOS 12.2, *) {
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V12_2)
        }
    }
    
    // MARK: Type manupulation
    
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
    
    private static func getCategoryType(_ index: Int) -> HKSampleType? {
        
        // It could be false if the requested type is not available for a given iOS version
        if HealthDataUtils.CATEGORY_TYPES.count <= index {
            return nil
        }
        let identifier = HealthDataUtils.CATEGORY_TYPES[index]
        return HKObjectType.categoryType(forIdentifier: identifier)
    }
    
    private static func getQuantityType(_ index: Int) -> HKSampleType? {
        
        // It could be false if the requested type is not available for a given iOS version
        if HealthDataUtils.QUANTITY_TYPES.count <= index {
            return nil
        }
        let identifier = HealthDataUtils.QUANTITY_TYPES[index].0
        return HKObjectType.quantityType(forIdentifier: identifier)
    }
    
    static func makeSampleSet(from list: HealthTypeList) -> Set<HKSampleType> {
        
        return Set(list.types.map { (helthType) -> HKSampleType? in
            HealthDataUtils.getSampleType(for: helthType)
        }.compactMap { $0 })
    }
}
