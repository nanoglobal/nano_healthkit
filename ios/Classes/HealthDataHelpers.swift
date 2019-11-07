//
import HealthKit

extension HealthDataUtils {}

extension HealthDataFetcher {
    
    // MARK: Data parsing
    
    func makeDataList(from samples: [Any]?, sampleType: HKObjectType, units: [HKUnit], healthType: HealthTypes) -> HealthDataList {
        
        var dataList = HealthDataList()
        for sample: Any in samples ?? [] {
            
            if let singleData = makeData(from: sample, sampleType: sampleType, units: units, healthType: healthType) {
                dataList.data.append(singleData)
            }
        }
        return dataList
    }
    
    func makeData(from sample: Any, sampleType: HKObjectType, units: [HKUnit], healthType: HealthTypes) -> HealthData? {
        
        var singleData: HealthData?
        if let workoutSample = sample as? HKWorkout {
            singleData = saveAsData(sampleType: sampleType, value: workoutSample, units: units, healthType: healthType)
        } else if let quantitySample = sample as? HKQuantitySample {
            singleData = saveAsData(sampleType: sampleType, value: quantitySample, units: units, healthType: healthType)
        } else if let categorySample = sample as? HKCategorySample {
            singleData = saveAsData(sampleType: sampleType, value: categorySample, healthType: healthType)
        } else if #available(iOS 12.0, *), let clinicalSample = sample as? HKClinicalRecord {
            singleData = saveAsData(sampleType: sampleType, value: clinicalSample, healthType: healthType)
        } else if #available(iOS 10.0, *), let documentSample = sample as? HKDocumentSample {
            singleData = saveAsData(sampleType: sampleType, value: documentSample, healthType: healthType)
        } else if let correlationSample = sample as? HKCorrelation {
            singleData = saveAsData(sampleType: sampleType, value: correlationSample, units: units, healthType: healthType)
        } else if let characteristicSample = sample as? (HKHealthStore, CharacteristicProcessType) {
            singleData = saveAsData(sampleType: sampleType, value: characteristicSample, healthType: healthType)
        }
        
        return singleData
    }
    
    private func saveAsDataBase(sampleType: HKObjectType, value: Any?, healthType: HealthTypes) -> HealthData {
        
        var data = HealthData()
        data.type = healthType
        data.objectType = sampleType.description
        if let sampleValue = value as? HKSample {
            saveBaseSampleInfo(data: &data, value: sampleValue)
        }
        return data
    }
    
    private func saveBaseSampleInfo(data: inout HealthData, value: HKSample) {
        
        data.startDate = value.startDate.iso8601
        data.endDate = value.endDate.iso8601
        data.device = value.device?.name ?? ""
        data.metadata = jsonToString(value.metadata)
        data.uuid = value.uuid.uuidString
        saveSourceRevisionInfo(data: &data.source, value: value.sourceRevision)
    }
    
    private func saveSourceRevisionInfo(data: inout SourceRevision, value: HKSourceRevision) {
        
        saveSourceInfo(data: &data, value: value.source)
        data.version = value.version ?? ""
        if #available(iOS 11.0, *) {
            data.productType = value.productType ?? ""
            let oSVer = value.operatingSystemVersion
            data.operatingSystemVersion = "\(oSVer.majorVersion).\(oSVer.minorVersion).\(oSVer.patchVersion)"
        }
    }
    
    private func saveSourceInfo(data: inout SourceRevision, value: HKSource) {
        
        data.name = value.name
        data.bundleIdentifier = value.bundleIdentifier
    }
    
    func saveAsData(sampleType: HKObjectType, value: (HKHealthStore, CharacteristicProcessType), healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: nil, healthType: healthType)
        let characteristicValue = value.1(value.0)
        if let valueDate = characteristicValue as? Date {
            data.characteristicData.value = valueDate.iso8601
        } else {
            data.characteristicData.value = "\(characteristicValue ?? "")"
        }
        return data
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKQuantitySample, units: [HKUnit], healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        if #available(iOS 12.0, *) {
            data.quantityData.count = Int64(value.count)
        }
        saveQuantityData(&data.quantityData, value: value.quantity, units: units, healthType: healthType)
        return data
    }
    
    func saveQuantityData(_ quantityData: inout QuantitySpecificData, value: HKQuantity, units: [HKUnit] = [], healthType: HealthTypes) {
        
        let index = HealthDataUtils.getTypeIndex(healthType)!
        
        // Make a list of possible units with the requested units first
        var unitList: [HKUnit] = []
        unitList.append(contentsOf: units)
        if index.1 == .quantity, let quantityUnit = HealthDataUtils.QUANTITY_TYPES[index.0].1 {
            unitList.append(quantityUnit)
        } else if index.1 == .correlation {
            unitList.append(contentsOf: HealthDataUtils.CORRELATION_TYPES[index.0].1)
        }
        
        // Use the first available unit
        for unit in unitList {
            if value.is(compatibleWith: unit) {
                quantityData.quantity = value.doubleValue(for: unit)
                quantityData.quantityUnit = unit.unitString
                return
            }
        }
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKCategorySample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.categoryData.value = Int64(value.value)
        return data
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKWorkout, units: [HKUnit], healthType: HealthTypes) -> HealthData {
        
        let index = HealthDataUtils.getTypeIndex(healthType)!
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        if let energyUnit = units.count > 0 ? units[0] : HealthDataUtils.WORKOUT_TYPES[index.0].1 {
            data.workoutData.totalEnergyBurned = value.totalEnergyBurned?.doubleValue(for: energyUnit) ?? 0
            data.workoutData.totalEnergyBurnedUnit = energyUnit.unitString
        }
        if let distanceUnit = units.count > 1 ? units[1] : HealthDataUtils.WORKOUT_TYPES[index.0].2 {
            data.workoutData.totalDistance = value.totalDistance?.doubleValue(for: distanceUnit) ?? 0
            data.workoutData.totalDistanceUnit = distanceUnit.unitString
        }
        data.workoutData.duration = value.duration
        data.workoutData.activityType = Int32(value.workoutActivityType.rawValue)
        
        return data
    }
    
    @available(iOS 12.0, *)
    func saveAsData(sampleType: HKObjectType, value: HKClinicalRecord, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.clinicalRecordData.displayName = value.displayName
        if let fhirData = value.fhirResource?.data, let fhirJson = String(data: fhirData, encoding: .ascii) {
            data.clinicalRecordData.fhirResource = fhirJson
        }
        return data
    }
    
    @available(iOS 10.0, *)
    func saveAsData(sampleType: HKObjectType, value: HKDocumentSample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        if let documentValue = value as? HKCDADocumentSample {
            data.documentData.authorName = documentValue.document?.authorName ?? ""
            data.documentData.custodianName = documentValue.document?.custodianName ?? ""
            data.documentData.patientName = documentValue.document?.patientName ?? ""
            data.documentData.title = documentValue.document?.title ?? ""
            data.documentData.documentData = jsonToString(documentValue.document?.documentData)
        }
        return data
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKCorrelation, units: [HKUnit], healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.correlationData.objects = value.objects.map { (object) -> HealthData in
            makeData(from: object, sampleType: sampleType, units: units, healthType: healthType)!
        }
        return data
    }
    
    func saveAsStatisticsData(response: HKStatistics?, healthType: HealthTypes, params: StatisticsParams) -> StatisticsData {
        
        var data = StatisticsData()
        if let sum = response?.sumQuantity() {
            saveQuantityData(&data.sumQuantity, value: sum, healthType: healthType)
        }
        if let average = response?.averageQuantity() {
            saveQuantityData(&data.averageQuantity, value: average, healthType: healthType)
        }
        if #available(iOS 13.0, *), let duration = response?.duration() {
            saveQuantityData(&data.duration, value: duration, healthType: healthType)
        }
        if let max = response?.maximumQuantity() {
            saveQuantityData(&data.maximumQuantity, value: max, healthType: healthType)
        }
        if let min = response?.minimumQuantity() {
            saveQuantityData(&data.minimumQuantity, value: min, healthType: healthType)
        }
        if #available(iOS 12.0, *), let mostRecent = response?.mostRecentQuantity() {
            saveQuantityData(&data.mostRecentQuantity, value: mostRecent, healthType: healthType)
        }
        if #available(iOS 12.0, *), let mostRecentDate = response?.mostRecentQuantityDateInterval() {
            data.mostRecentQuantityDateInterval.startDate = mostRecentDate.start.iso8601
            data.mostRecentQuantityDateInterval.endDate = mostRecentDate.end.iso8601
        }
        data.dataInterval.startDate = response?.startDate.iso8601 ?? ""
        data.dataInterval.endDate = response?.endDate.iso8601 ?? ""
        for source in response?.sources ?? [] {
            var ownSource = SourceRevision()
            saveSourceInfo(data: &ownSource, value: source)
            data.sources.append(ownSource)
            
            if params.statisticsOptions.contains(.separateBySource) {
                saveAsStatisticsDataBySource(response: response, healthType: healthType, data: &data, source: source, ownSource: ownSource)
            }
        }
        return data
    }
    
    private func saveAsStatisticsDataBySource(response: HKStatistics?, healthType: HealthTypes, data: inout StatisticsData, source: HKSource, ownSource: SourceRevision) {
        
        var dataBySource = StatisticsData.StatisticsDataBySource()
        dataBySource.source = ownSource
        if let sum = response?.sumQuantity(for: source) {
            saveQuantityData(&dataBySource.data.sumQuantity, value: sum, healthType: healthType)
        }
        if let average = response?.averageQuantity(for: source) {
            saveQuantityData(&dataBySource.data.averageQuantity, value: average, healthType: healthType)
        }
        if #available(iOS 13.0, *), let duration = response?.duration(for: source) {
            saveQuantityData(&dataBySource.data.duration, value: duration, healthType: healthType)
        }
        if let max = response?.maximumQuantity(for: source) {
            saveQuantityData(&dataBySource.data.maximumQuantity, value: max, healthType: healthType)
        }
        if let min = response?.minimumQuantity(for: source) {
            saveQuantityData(&dataBySource.data.minimumQuantity, value: min, healthType: healthType)
        }
        if #available(iOS 12.0, *), let mostRecent = response?.mostRecentQuantity(for: source) {
            saveQuantityData(&dataBySource.data.mostRecentQuantity, value: mostRecent, healthType: healthType)
        }
        if #available(iOS 12.0, *), let mostRecentDate = response?.mostRecentQuantityDateInterval(for: source) {
            dataBySource.data.mostRecentQuantityDateInterval.startDate = mostRecentDate.start.iso8601
            dataBySource.data.mostRecentQuantityDateInterval.endDate = mostRecentDate.end.iso8601
        }
        
        data.dataBySource.append(dataBySource)
    }
    
    private func jsonToString(_ jsonDictionary: [String: Any]?) -> String {
        
        if let jsonDictionary = jsonDictionary, let jsonData = try? JSONSerialization.data(
            withJSONObject: jsonDictionary, options: []) {
            return jsonToString(jsonData)
        }
        return ""
    }
    
    private func jsonToString(_ jsonData: Data?) -> String {
        
        var jsonText: String?
        if jsonData != nil {
            jsonText = String(data: jsonData!, encoding: .ascii)
        }
        return jsonText ?? ""
    }
}

// MARK: Store data

extension HealthDataUtils {
    
    static func writeValue(_ value: Any?, key: String) {
        
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func readValue<T: Any>(type: T.Type, key: String) -> T? {
        
        let preferences = UserDefaults.standard
        switch type {
        case is Data.Type:
            return preferences.data(forKey: key) as? T
        case is [String].Type:
            return preferences.stringArray(forKey: key) as? T
        case is String.Type:
            return preferences.string(forKey: key) as? T
        default:
            return nil
        }
    }
    
    func getAnchor(anchorKey: String) -> HKQueryAnchor? {
        
        guard let encoded = HealthDataUtils.readValue(type: Data.self, key: anchorKey) else {
            return nil
        }
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: encoded) as? HKQueryAnchor
        return anchor
    }
    
    func saveAnchor(anchor: HKQueryAnchor, anchorKey: String) {
        
        let encoded = NSKeyedArchiver.archivedData(withRootObject: anchor)
        HealthDataUtils.writeValue(encoded, key: anchorKey)
    }
}

// MARK: Errors

struct SimpleLocalizedError: LocalizedError {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String? = nil, _ description: String, code: Int = 0) {
        self.title = title == nil ? "" : title
        self._description = description
        self.code = code
    }
}

// MARK: Time

extension Formatter {
    
    static let iso8601: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        
        return dateFormatter
    }()
}

extension Date {
    
    init(fromMillis: Int64?) {
        self = Date(timeIntervalSince1970: TimeInterval((fromMillis ?? 0) / 1000))
    }
    
    // Note: ISO8601 string format: yyyy-MM-dd'T'HH:mm:ss.SSSZ.
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    init(iso8601: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        self = dateFormatter.date(from: iso8601) ?? Date()
    }
}
