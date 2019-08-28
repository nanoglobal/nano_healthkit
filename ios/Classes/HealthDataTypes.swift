//
import HealthKit

extension HealthDataUtils {
    
    enum SampleTypes: Int {
        case category = 0
        case quantity
        case workout
        case characteristic
    }

    
    private static var WORKOUT_TYPES_V8_0: [HKSampleType] = [
        HKObjectType.workoutType(),
    ]
    
    private static var CATEGORY_TYPES_V8_0: [HKCategoryTypeIdentifier] = [
        .sleepAnalysis,
        .appleStandHour,
        .cervicalMucusQuality,
        .ovulationTestResult,
        .menstrualFlow,
        .intermenstrualBleeding,
        .sexualActivity,
    ]
    
    @available(iOS 10.0, *)
    private static var CATEGORY_TYPES_V10_0: [HKCategoryTypeIdentifier] = [
        .mindfulSession,
    ]
    
    @available(iOS 12.2, *)
    private static var CATEGORY_TYPES_V12_2: [HKCategoryTypeIdentifier] = [
        .highHeartRateEvent,
        .lowHeartRateEvent,
        .irregularHeartRhythmEvent,
    ]
    
    private static var QUANTITY_TYPES_V8_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
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
    private static var QUANTITY_TYPES_V9_3: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.appleExerciseTime, .second()),
    ]
    
    @available(iOS 10.0, *)
    private static var QUANTITY_TYPES_V10_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.distanceWheelchair, .meter()),
        (.pushCount, .count()),
        (.distanceSwimming, .meter()),
        (.swimmingStrokeCount, .count()),
    ]
    
    @available(iOS 11.0, *)
    private static var QUANTITY_TYPES_V11_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
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
    private static var QUANTITY_TYPES_V11_2: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.distanceDownhillSnowSports, .meter()),
    ]
    
    @available(iOS 8.0, *)
    private static var CHARACTERISTIC_TYPES_V8_0: [(HKCharacteristicTypeIdentifier, ((HKHealthStore) -> Any?))] = [
        (.biologicalSex, {return try? $0.biologicalSex().biologicalSex.rawValue}), // Enum, Int
        (.bloodType, {return try? $0.bloodType().bloodType.rawValue }), // Enum, Int
        (.dateOfBirth, {return try? $0.dateOfBirth().timeIntervalSince1970 }), // Date, Double
    ]
    
    @available(iOS 9.0, *)
    private static var CHARACTERISTIC_TYPES_V9_0: [(HKCharacteristicTypeIdentifier, ((HKHealthStore) -> Any?))] = [
        (.fitzpatrickSkinType, {return try? $0.fitzpatrickSkinType().skinType.rawValue}), // Enum, Int
    ]
    
    @available(iOS 10.0, *)
    private static var CHARACTERISTIC_TYPES_V10_0: [(HKCharacteristicTypeIdentifier, ((HKHealthStore) -> Any?))] = [
        (.wheelchairUse, {return try? $0.wheelchairUse().wheelchairUse.rawValue}), // Enum, Int
    ]
    
    private static var TYPE_INDEXES: [HealthTypes: (Int, SampleTypes)] = [
        .workoutMain: (0, .workout),
        .categorySleepAnalysis: (0, .category),
        .categoryAppleStandHour: (1, .category),
        .categoryCervicalMucusQuality: (2, .category),
        .categoryOvulationTestResult: (3, .category),
        .categoryMenstrualFlow: (4, .category),
        .categoryIntermenstrualBleeding: (5, .category),
        .categorySexualActivity: (6, .category),
        .categoryMindfulSession: (7, .category),
        .categoryHighHeartRateEvent: (8, .category),
        .categoryLowHeartRateEvent: (9, .category),
        .categoryIrregularHeartRhythmEvent: (10, .category),
        .quantityBodyMassIndex: (0, .quantity),
        .quantityBodyFatPercentage: (1, .quantity),
        .quantityHeight: (2, .quantity),
        .quantityBodyMass: (3, .quantity),
        .quantityLeanBodyMass: (4, .quantity),
        .quantityStepCount: (5, .quantity),
        .quantityDistanceWalkingRunning: (6, .quantity),
        .quantityDistanceCycling: (7, .quantity),
        .quantityBasalEnergyBurned: (8, .quantity),
        .quantityActiveEnergyBurned: (9, .quantity),
        .quantityFlightsClimbed: (10, .quantity),
        .quantityNikeFuel: (11, .quantity),
        .quantityHeartRate: (12, .quantity),
        .quantityBodyTemperature: (13, .quantity),
        .quantityBasalBodyTemperature: (14, .quantity),
        .quantityBloodPressureSystolic: (15, .quantity),
        .quantityBloodPressureDiastolic: (16, .quantity),
        .quantityRespiratoryRate: (17, .quantity),
        .quantityOxygenSaturation: (18, .quantity),
        .quantityPeripheralPerfusionIndex: (19, .quantity),
        .quantityBloodGlucose: (20, .quantity),
        .quantityNumberOfTimesFallen: (21, .quantity),
        .quantityElectrodermalActivity: (22, .quantity),
        .quantityInhalerUsage: (23, .quantity),
        .quantityBloodAlcoholContent: (24, .quantity),
        .quantityForcedVitalCapacity: (25, .quantity),
        .quantityForcedExpiratoryVolume1: (26, .quantity),
        .quantityPeakExpiratoryFlowRate: (27, .quantity),
        .quantityDietaryFatTotal: (28, .quantity),
        .quantityDietaryFatPolyunsaturated: (29, .quantity),
        .quantityDietaryFatMonounsaturated: (30, .quantity),
        .quantityDietaryFatSaturated: (31, .quantity),
        .quantityDietaryCholesterol: (32, .quantity),
        .quantityDietarySodium: (33, .quantity),
        .quantityDietaryCarbohydrates: (34, .quantity),
        .quantityDietaryFiber: (35, .quantity),
        .quantityDietarySugar: (36, .quantity),
        .quantityDietaryEnergyConsumed: (37, .quantity),
        .quantityDietaryProtein: (38, .quantity),
        .quantityDietaryVitaminA: (39, .quantity),
        .quantityDietaryVitaminB6: (40, .quantity),
        .quantityDietaryVitaminB12: (41, .quantity),
        .quantityDietaryVitaminC: (42, .quantity),
        .quantityDietaryVitaminD: (43, .quantity),
        .quantityDietaryVitaminE: (44, .quantity),
        .quantityDietaryVitaminK: (45, .quantity),
        .quantityDietaryCalcium: (46, .quantity),
        .quantityDietaryIron: (47, .quantity),
        .quantityDietaryThiamin: (48, .quantity),
        .quantityDietaryRiboflavin: (49, .quantity),
        .quantityDietaryNiacin: (50, .quantity),
        .quantityDietaryFolate: (51, .quantity),
        .quantityDietaryBiotin: (52, .quantity),
        .quantityDietaryPantothenicAcid: (53, .quantity),
        .quantityDietaryPhosphorus: (54, .quantity),
        .quantityDietaryIodine: (55, .quantity),
        .quantityDietaryMagnesium: (56, .quantity),
        .quantityDietaryZinc: (57, .quantity),
        .quantityDietarySelenium: (58, .quantity),
        .quantityDietaryCopper: (59, .quantity),
        .quantityDietaryManganese: (60, .quantity),
        .quantityDietaryChromium: (61, .quantity),
        .quantityDietaryMolybdenum: (62, .quantity),
        .quantityDietaryChloride: (63, .quantity),
        .quantityDietaryPotassium: (64, .quantity),
        .quantityDietaryCaffeine: (65, .quantity),
        .quantityDietaryWater: (66, .quantity),
        .quantityUvExposure: (67, .quantity),
        .quantityAppleExerciseTime: (68, .quantity),
        .quantityDistanceWheelchair: (69, .quantity),
        .quantityPushCount: (70, .quantity),
        .quantityDistanceSwimming: (71, .quantity),
        .quantitySwimmingStrokeCount: (72, .quantity),
        .quantityWaistCircumference: (73, .quantity),
        .quantityVo2Max: (74, .quantity),
        .quantityRestingHeartRate: (75, .quantity),
        .quantityWalkingHeartRateAverage: (76, .quantity),
        .quantityHeartRateVariabilitySdnn: (77, .quantity),
        .quantityInsulinDelivery: (78, .quantity),
        .quantityDistanceDownhillSnowSports: (79, .quantity),
        .characteristicBiologicalSex: (0, .characteristic),
        .characteristicBloodType: (1, .characteristic),
        .characteristicDateOfBirth: (2, .characteristic),
        .characteristicFitzpatrickSkinType: (3, .characteristic),
        .characteristicWheelchairUse: (4, .characteristic),
    ]
    
    func fillTypes() {
        
        if #available(iOS 8.0, *) {
            HealthDataUtils.WORKOUT_TYPES.append(contentsOf: HealthDataUtils.WORKOUT_TYPES_V8_0)
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V8_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V8_0)
            HealthDataUtils.CHARACTERISTIC_TYPES.append(contentsOf: HealthDataUtils.CHARACTERISTIC_TYPES_V8_0)
        }
        
        if #available(iOS 9.0, *) {
            HealthDataUtils.CHARACTERISTIC_TYPES.append(contentsOf: HealthDataUtils.CHARACTERISTIC_TYPES_V9_0)
        }
        
        if #available(iOS 9.3, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V9_3)
        }
        
        if #available(iOS 10.0, *) {
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V10_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V10_0)
            HealthDataUtils.CHARACTERISTIC_TYPES.append(contentsOf: HealthDataUtils.CHARACTERISTIC_TYPES_V10_0)
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
    
    static func getTypeIndex(_ healthType: HealthTypes) -> (Int, SampleTypes)? {
        
        guard let index = TYPE_INDEXES[healthType] else {
            return nil
        }
        var totalAmount = 0
        switch index.1 {
        case .workout:
            totalAmount = HealthDataUtils.WORKOUT_TYPES.count
        case .quantity:
            totalAmount = HealthDataUtils.QUANTITY_TYPES.count
        case .category:
            totalAmount = HealthDataUtils.CATEGORY_TYPES.count
        case .characteristic:
            totalAmount = HealthDataUtils.CHARACTERISTIC_TYPES.count
        }
        return totalAmount <= index.0 ? nil : index
    }
    
    static func typeExists(_ healthType: HealthTypes) -> Bool {
        return getTypeIndex(healthType) != nil
    }
    
    // MARK: Type manupulation
    
    static func getSampleType(for healthType: HealthTypes) -> HKObjectType? {
        
        guard let index = getTypeIndex(healthType)else {
            return nil
        }
        switch index.1 {
        case .workout:
            return HealthDataUtils.WORKOUT_TYPES[index.0]
        case .quantity:
            return getQuantityType(index.0)
        case .category:
            return getCategoryType(index.0)
        case .characteristic:
            return getCharacteristicType(index.0)
        }
    }
    
    private static func getCategoryType(_ index: Int) -> HKSampleType? {

        let identifier = HealthDataUtils.CATEGORY_TYPES[index]
        return HKObjectType.categoryType(forIdentifier: identifier)
    }
    
    private static func getQuantityType(_ index: Int) -> HKSampleType? {

        let identifier = HealthDataUtils.QUANTITY_TYPES[index].0
        return HKObjectType.quantityType(forIdentifier: identifier)
    }
    
    private static func getCharacteristicType(_ index: Int) -> HKCharacteristicType? {

        let identifier = HealthDataUtils.CHARACTERISTIC_TYPES[index].0
        return HKObjectType.characteristicType(forIdentifier: identifier)
    }
    
    static func makeSampleSet(from list: HealthTypeList) -> Set<HKObjectType> {
        
        return Set(list.types.map { (helthType) -> HKObjectType? in
            HealthDataUtils.getSampleType(for: helthType)
        }.compactMap { $0 })
    }
}
