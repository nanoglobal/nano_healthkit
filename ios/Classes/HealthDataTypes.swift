//
import HealthKit

extension HealthDataUtils {
    
    enum SampleTypes: Int {
        case category = 0
        case quantity
        case workout
        case characteristic
        case clinical
        case document
        case correlation
    }
    
    // MARK: Workout
    
    private static var WORKOUT_TYPES_V8_0: [(HKSampleType, HKUnit?, HKUnit?)] = [
        (HKObjectType.workoutType(), .joule(), .meter()),
    ]
    
    // MARK: Category
    
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
    
    @available(iOS 13.0, *)
    private static var CATEGORY_TYPES_V13_0: [HKCategoryTypeIdentifier] = [
        .audioExposureEvent,
        .toothbrushingEvent,
    ]
    
    // MARK: Quantity
    
    private static var QUANTITY_TYPES_V8_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.bodyMassIndex, HKUnit.init(from: "count")),
        (.bodyFatPercentage, .percent()),
        (.height, .meter()),
        (.bodyMass, HKUnit.gramUnit(with: .kilo)),
        (.leanBodyMass, HKUnit.gramUnit(with: .kilo)),
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
        (.bodyTemperature, .kelvin()),
        (.basalBodyTemperature, .kelvin()),
        (.bloodPressureSystolic, .pascal()),
        (.bloodPressureDiastolic, .pascal()),
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
        (.dietaryFatTotal, HKUnit.gramUnit(with: .kilo)),
        (.dietaryFatPolyunsaturated, HKUnit.gramUnit(with: .kilo)),
        (.dietaryFatMonounsaturated, HKUnit.gramUnit(with: .kilo)),
        (.dietaryFatSaturated, HKUnit.gramUnit(with: .kilo)),
        (.dietaryCholesterol, HKUnit.gramUnit(with: .kilo)),
        (.dietarySodium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryCarbohydrates, HKUnit.gramUnit(with: .kilo)),
        (.dietaryFiber, HKUnit.gramUnit(with: .kilo)),
        (.dietarySugar, HKUnit.gramUnit(with: .kilo)),
        (.dietaryEnergyConsumed, .joule()),
        (.dietaryProtein, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminA, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminB6, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminB12, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminC, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminD, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminE, HKUnit.gramUnit(with: .kilo)),
        (.dietaryVitaminK, HKUnit.gramUnit(with: .kilo)),
        (.dietaryCalcium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryIron, HKUnit.gramUnit(with: .kilo)),
        (.dietaryThiamin, HKUnit.gramUnit(with: .kilo)),
        (.dietaryRiboflavin, HKUnit.gramUnit(with: .kilo)),
        (.dietaryNiacin, HKUnit.gramUnit(with: .kilo)),
        (.dietaryFolate, HKUnit.gramUnit(with: .kilo)),
        (.dietaryBiotin, HKUnit.gramUnit(with: .kilo)),
        (.dietaryPantothenicAcid, HKUnit.gramUnit(with: .kilo)),
        (.dietaryPhosphorus, HKUnit.gramUnit(with: .kilo)),
        (.dietaryIodine, HKUnit.gramUnit(with: .kilo)),
        (.dietaryMagnesium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryZinc, HKUnit.gramUnit(with: .kilo)),
        (.dietarySelenium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryCopper, HKUnit.gramUnit(with: .kilo)),
        (.dietaryManganese, HKUnit.gramUnit(with: .kilo)),
        (.dietaryChromium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryMolybdenum, HKUnit.gramUnit(with: .kilo)),
        (.dietaryChloride, HKUnit.gramUnit(with: .kilo)),
        (.dietaryPotassium, HKUnit.gramUnit(with: .kilo)),
        (.dietaryCaffeine, HKUnit.gramUnit(with: .kilo)),
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
    
    @available(iOS 13.0, *)
    private static var QUANTITY_TYPES_V13_0: [(HKQuantityTypeIdentifier, HKUnit?)] = [
        (.appleStandTime, .second()),
        (.environmentalAudioExposure, .pascal()),
        (.headphoneAudioExposure, .pascal()),
    ]
    
    // MARK: Characteristics
    
    @available(iOS 8.0, *)
    private static var CHARACTERISTIC_TYPES_V8_0: [(HKCharacteristicTypeIdentifier, CharacteristicProcessType)] = [
        (.biologicalSex, { try? $0.biologicalSex().biologicalSex.rawValue }), // Enum, Int
        (.bloodType, { try? $0.bloodType().bloodType.rawValue }), // Enum, Int
        (.dateOfBirth, { try? $0.dateOfBirth() }), // Date, Date
    ]
    
    @available(iOS 9.0, *)
    private static var CHARACTERISTIC_TYPES_V9_0: [(HKCharacteristicTypeIdentifier, CharacteristicProcessType)] = [
        (.fitzpatrickSkinType, { try? $0.fitzpatrickSkinType().skinType.rawValue }), // Enum, Int
    ]
    
    @available(iOS 10.0, *)
    private static var CHARACTERISTIC_TYPES_V10_0: [(HKCharacteristicTypeIdentifier, CharacteristicProcessType)] = [
        (.wheelchairUse, { try? $0.wheelchairUse().wheelchairUse.rawValue }), // Enum, Int
    ]
    
    // MARK: Clinical
    
    @available(iOS 12.0, *)
    private static var CLINICAL_TYPES_V12_0: [HKClinicalTypeIdentifier] = [
        .allergyRecord,
        .conditionRecord,
        .immunizationRecord,
        .labResultRecord,
        .medicationRecord,
        .procedureRecord,
        .vitalSignRecord,
    ]
    
    // MARK: Document
    
    @available(iOS 10.0, *)
    private static var DOCUMENT_TYPES_V10_0: [HKDocumentTypeIdentifier] = [
        .CDA,
    ]
    
    // MARK: Correlation
    
    private static var CORRELATION_TYPES_V8_0: [(HKCorrelationTypeIdentifier, [HKUnit])] = [
        (.bloodPressure, [.pascal()]),
        (.food, [HKUnit.gramUnit(with: .kilo), .pascal(), .meter(), .liter(), .percent()]),
    ]
    
    // MARK: Indexes
    
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
        .categoryAudioExposureEvent: (11, .category),
        .categoryToothbrushingEvent: (12, .category),
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
        .quantityAppleStandTime: (80, .quantity),
        .quantityEnvironmentalAudioExposure: (81, .quantity),
        .quantityHeadphoneAudioExposure: (82, .quantity),
        .characteristicBiologicalSex: (0, .characteristic),
        .characteristicBloodType: (1, .characteristic),
        .characteristicDateOfBirth: (2, .characteristic),
        .characteristicFitzpatrickSkinType: (3, .characteristic),
        .characteristicWheelchairUse: (4, .characteristic),
        .clinicalAllergyRecord: (0, .clinical),
        .clinicalConditionRecord: (1, .clinical),
        .clinicalImmunizationRecord: (2, .clinical),
        .clinicalLabResultRecord: (3, .clinical),
        .clinicalMedicationRecord: (4, .clinical),
        .clinicalProcedureRecord: (5, .clinical),
        .clinicalVitalSignRecord: (6, .clinical),
        .documentCda: (0, .document),
        .correlationBloodPressure: (0, .correlation),
        .correlationFood: (1, .correlation),
    ]
    
    // MARK: Statistics
    
    private static let STATISTICS_OPTIONS_MAP_V8_0: [StatisticsOptions: HKStatisticsOptions] = [
        .discreteAverage: .discreteAverage,
        .discreteMin: .discreteMin,
        .discreteMax: .discreteMax,
        .cumulativeSum: .cumulativeSum,
        .separateBySource: .separateBySource,
    ]
    
    @available(iOS 13.0, *)
    private static let STATISTICS_OPTIONS_MAP_V13_0: [StatisticsOptions: HKStatisticsOptions] = [
        .mostRecent: .mostRecent,
        .duration: .duration,
    ]
    
    // MARK: Methods
    
    func fillTypes() {
        
        if #available(iOS 8.0, *) {
            HealthDataUtils.WORKOUT_TYPES.append(contentsOf: HealthDataUtils.WORKOUT_TYPES_V8_0)
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V8_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V8_0)
            HealthDataUtils.CHARACTERISTIC_TYPES.append(contentsOf: HealthDataUtils.CHARACTERISTIC_TYPES_V8_0)
            HealthDataUtils.CORRELATION_TYPES.append(contentsOf: HealthDataUtils.CORRELATION_TYPES_V8_0)
            HealthDataUtils.STATISTICS_OPTIONS_MAP.addEntries(from: HealthDataUtils.STATISTICS_OPTIONS_MAP_V8_0)
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
            HealthDataUtils.DOCUMENT_TYPES.append(contentsOf: HealthDataUtils.DOCUMENT_TYPES_V10_0)
        }
        
        if #available(iOS 11.0, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V11_0)
        }
        
        if #available(iOS 11.2, *) {
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V11_2)
        }
        
        if #available(iOS 12.0, *) {
            HealthDataUtils.CLINICAL_TYPES.append(contentsOf: HealthDataUtils.CLINICAL_TYPES_V12_0)
        }
        
        if #available(iOS 12.2, *) {
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V12_2)
        }
        
        if #available(iOS 13.0, *) {
            HealthDataUtils.STATISTICS_OPTIONS_MAP.addEntries(from: HealthDataUtils.STATISTICS_OPTIONS_MAP_V13_0)
            HealthDataUtils.QUANTITY_TYPES.append(contentsOf: HealthDataUtils.QUANTITY_TYPES_V13_0)
            HealthDataUtils.CATEGORY_TYPES.append(contentsOf: HealthDataUtils.CATEGORY_TYPES_V13_0)
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
        case .clinical:
            totalAmount = HealthDataUtils.CLINICAL_TYPES.count
        case .document:
            totalAmount = HealthDataUtils.DOCUMENT_TYPES.count
        case .correlation:
            totalAmount = HealthDataUtils.CORRELATION_TYPES.count
        }
        return totalAmount <= index.0 ? nil : index
    }
    
    static func typeExists(_ healthType: HealthTypes) -> Bool {
        return getTypeIndex(healthType) != nil
    }
    
    // MARK: Type manupulation
    
    static func getHKObjectType(for healthType: HealthTypes) -> HKObjectType? {
        
        guard let index = getTypeIndex(healthType) else {
            return nil
        }
        switch index.1 {
        case .workout:
            return HealthDataUtils.WORKOUT_TYPES[index.0].0
        case .quantity:
            return getQuantityType(index.0)
        case .category:
            return getCategoryType(index.0)
        case .characteristic:
            return getCharacteristicType(index.0)
        case .clinical:
            return getClinicalType(index.0)
        case .document:
            return getDocumentType(index.0)
        case .correlation:
            return getCorrelationType(index.0)
        }
    }
    
    static func makeHKObject(for healthData: HealthData) -> HKObject?{
        
        guard let index = getTypeIndex(healthData.type) else {
                   return nil
        }
        
        let startDate = Date(timeIntervalSince1970: Double(healthData.startDate) ?? Date.init().timeIntervalSinceNow)
        let endDate = Date(timeIntervalSince1970: Double(healthData.endDate) ?? Date.init().timeIntervalSinceNow)
        
        let device =  HKDevice(name: healthData.device, manufacturer: nil, model: nil, hardwareVersion: nil, firmwareVersion: nil, softwareVersion: nil, localIdentifier: nil, udiDeviceIdentifier: nil)
        
        switch index.1 {
        case .workout:
            let eneryBurnedUnit = HKUnit(from: healthData.workoutData.totalEnergyBurnedUnit)
            let eneryBurned = HKQuantity(unit: eneryBurnedUnit, doubleValue: healthData.workoutData.totalEnergyBurned)
            
            let distanceUnit = HKUnit(from: healthData.workoutData.totalDistanceUnit)
            let distance = HKQuantity(unit: distanceUnit, doubleValue: healthData.workoutData.totalDistance)
            
            let type = HKWorkoutActivityType(rawValue: UInt(healthData.workoutData.activityType))//TODO Chris falta cuando lee
            
            return HKWorkout(activityType: type!, start: startDate, end: endDate, duration: healthData.workoutData.duration,
                                   totalEnergyBurned: eneryBurned, totalDistance: distance, device: device, metadata:["metadata":healthData.metadata] )
            
        case .quantity:
            let identifier = HealthDataUtils.QUANTITY_TYPES[index.0].0
            let quantityType = HKQuantityType.quantityType(forIdentifier: identifier)
            let quanitytUnit = HKUnit(from: healthData.quantityData.quantityUnit)
            let quantityAmount = HKQuantity(unit: quanitytUnit, doubleValue: healthData.quantityData.quantity)
            return  HKQuantitySample(type: quantityType!, quantity: quantityAmount, start: startDate, end: endDate)
            
        case .category:
            let identifier = HealthDataUtils.CATEGORY_TYPES [index.0]
            let categoryType = HKCategoryType.categoryType(forIdentifier: identifier)
            return  HKCategorySample(type: categoryType!, value: Int(healthData.categoryData.value), start: startDate, end: endDate, device: device, metadata:["metadata":healthData.metadata] )
            
        case .characteristic:
            return nil
            
        case .clinical:
            return nil
            
        case .document:
            if #available(iOS 10.0, *) {
              let data = Data.init(base64Encoded: healthData.documentData.documentData)
              do {
                  let sample = try HKCDADocumentSample(data: data!, start: startDate, end: endDate, metadata:["metadata":healthData.metadata])
                  return sample
              } catch  {
                  return nil
              }
            } else {
                // Fallback on earlier versions
                return nil
            }
        case .correlation:
            return nil
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
    
    private static func getClinicalType(_ index: Int) -> HKSampleType? {
        
        if #available(iOS 12.0, *) {
            let identifier = HealthDataUtils.CLINICAL_TYPES[index] as! HKClinicalTypeIdentifier
            return HKObjectType.clinicalType(forIdentifier: identifier)
        }
        return nil
    }
    
    private static func getDocumentType(_ index: Int) -> HKSampleType? {
        
        if #available(iOS 10.0, *) {
            let identifier = HealthDataUtils.DOCUMENT_TYPES[index]
            return HKObjectType.documentType(forIdentifier: identifier)
        }
        return nil
    }
    
    private static func getCorrelationType(_ index: Int) -> HKSampleType? {
        
        let identifier = HealthDataUtils.CORRELATION_TYPES[index].0
        return HKObjectType.correlationType(forIdentifier: identifier)
    }
    
    static func makeHKObjectSet(from list: HealthTypeList) -> Set<HKObjectType> {
        
        return Set(list.types.map { (helthType) -> HKObjectType? in
            HealthDataUtils.getHKObjectType(for: helthType)
        }.compactMap { $0 })
    }
    
    
    static func makeHKSampleSet(from list: HealthTypeList) -> Set<HKSampleType> {
           
           return Set(list.types.map { (helthType) -> HKSampleType? in
               HealthDataUtils.getHKObjectType(for: helthType) as? HKSampleType
           }.compactMap { $0 })
       }
    
    static func makeFilteredToupleList<T: HKObjectType>(from list: HealthTypeList) -> [(HealthTypes, T)] {
        
        let filteredList = filterExistingTypes(list)
        return filteredList.types.map { (helthType) -> (HealthTypes, T)? in
            if let obj = HealthDataUtils.getHKObjectType(for: helthType) as? T {
                return (helthType, obj)
            }
            return nil
        }.compactMap { $0 }
    }
    
    static func filterExistingTypes(_ list: HealthTypeList) -> HealthTypeList {
        return filterTypes(list, function: { HealthDataUtils.typeExists($0) })
    }
    
    static func filterPermissionRequiredTypes(_ list: HealthTypeList) -> HealthTypeList {
        return filterTypes(list, function: {
            if let index = HealthDataUtils.getTypeIndex($0) {
                return (index.1 != .correlation)
            }
            return false
        })
    }
    
    static func filterTypes(_ list: HealthTypeList, function: (HealthTypes) -> Bool) -> HealthTypeList {
        
        var filteredList = HealthTypeList()
        for elem in list.types {
            if function(elem) {
                filteredList.types.append(elem)
            }
        }
        return filteredList
    }
    
    static func filterWriteRequiredTypes(_ list: HealthTypeList) -> HealthTypeList {
       let writeFilteredList =  HealthDataUtils.filterPermissionRequiredTypes(list)
        
       var filteredList = HealthTypeList()
       for elem in writeFilteredList.types {
            if !FORBIDDEN_WRITE_LIST.contains(elem){
               filteredList.types.append(elem)
           }
       }
       return filteredList
        
    }
    
    private static var FORBIDDEN_WRITE_LIST:[HealthTypes] = [
        .characteristicBiologicalSex,
        .characteristicBloodType,
        .characteristicDateOfBirth ,
        .characteristicFitzpatrickSkinType,
        .characteristicWheelchairUse ,
        .clinicalAllergyRecord,
        .clinicalConditionRecord,
        .clinicalImmunizationRecord,
        .clinicalLabResultRecord,
        .clinicalMedicationRecord,
        .clinicalProcedureRecord,
        .clinicalVitalSignRecord,
        .quantityWalkingHeartRateAverage,
        .quantityAppleStandTime,
        .quantityNikeFuel,
        .quantityAppleExerciseTime,
        .categoryLowHeartRateEvent,
        .categoryAppleStandHour,
        .categoryAudioExposureEvent,
        .categoryHighHeartRateEvent,
        .categoryIrregularHeartRhythmEvent,
        .correlationBloodPressure,
        .correlationFood,
    ]
}
