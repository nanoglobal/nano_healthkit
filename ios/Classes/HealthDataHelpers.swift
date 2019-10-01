//
import HealthKit

extension HealthDataUtils {}

extension HealthDataFetcher {
    
    // MARK: Data parsing
    
    func makeDataList(from samples: [Any]?, sampleType: HKObjectType, healthType: HealthTypes) -> HealthDataList {
        
        var dataList = HealthDataList()
        for sample: Any in samples ?? [] {
            
            if let singleData = makeData(from: sample, sampleType: sampleType, healthType: healthType) {
                dataList.data.append(singleData)
            }
        }
        return dataList
    }
    
    func makeData(from sample: Any, sampleType: HKObjectType, healthType: HealthTypes) -> HealthData? {
        
        var singleData: HealthData?
        if let workoutSample = sample as? HKWorkout {
            singleData = saveAsData(sampleType: sampleType, value: workoutSample, healthType: healthType)
        } else if let quantitySample = sample as? HKQuantitySample {
            singleData = saveAsData(sampleType: sampleType, value: quantitySample, healthType: healthType)
        } else if let categorySample = sample as? HKCategorySample {
            singleData = saveAsData(sampleType: sampleType, value: categorySample, healthType: healthType)
        } else if #available(iOS 12.0, *), let clinicalSample = sample as? HKClinicalRecord {
            singleData = saveAsData(sampleType: sampleType, value: clinicalSample, healthType: healthType)
        } else if #available(iOS 10.0, *), let documentSample = sample as? HKDocumentSample {
            singleData = saveAsData(sampleType: sampleType, value: documentSample, healthType: healthType)
        } else if let correlationSample = sample as? HKCorrelation {
            singleData = saveAsData(sampleType: sampleType, value: correlationSample, healthType: healthType)
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
    
    func saveAsData(sampleType: HKObjectType, value: HKQuantitySample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        if #available(iOS 12.0, *) {
            data.quantityData.count = Int64(value.count)
        }
        saveQuantityData(&data.quantityData, value: value.quantity, healthType: healthType)
        return data
    }
    
    func saveQuantityData(_ quantityData: inout QuantitySpecificData, value: HKQuantity, healthType: HealthTypes) {
        
        let index = HealthDataUtils.getTypeIndex(healthType)!
        
        if let unit = HealthDataUtils.QUANTITY_TYPES[index.0].1 {
            quantityData.quantityUnit = unit.unitString
            quantityData.quantity = value.doubleValue(for: unit)
        }
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKCategorySample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.categoryData.value = Int64(value.value)
        return data
    }
    
    func saveAsData(sampleType: HKObjectType, value: HKWorkout, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.workoutData.totalEnergyBurned = value.totalEnergyBurned?.doubleValue(for: .joule()) ?? 0
        data.workoutData.totalEnergyBurnedUnit = HKUnit.joule().unitString
        data.workoutData.totalDistance = value.totalDistance?.doubleValue(for: .meter()) ?? 0
        data.workoutData.totalDistanceUnit = HKUnit.meter().unitString
        data.workoutData.duration = value.duration
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
    
    func saveAsData(sampleType: HKObjectType, value: HKCorrelation, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.correlationData.objects = value.objects.map { (object) -> HealthData in
            makeData(from: object, sampleType: sampleType, healthType: healthType)!
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
    
    func getAnchor(anchorKey: String) -> HKQueryAnchor? {
        
        let encoded = UserDefaults.standard.data(forKey: anchorKey)
        if encoded == nil {
            return nil
        }
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: encoded!) as? HKQueryAnchor
        return anchor
    }
    
    func saveAnchor(anchor: HKQueryAnchor, anchorKey: String) {
        
        let encoded = NSKeyedArchiver.archivedData(withRootObject: anchor)
        UserDefaults.standard.setValue(encoded, forKey: anchorKey)
        UserDefaults.standard.synchronize()
    }
}

class HealthStatusRecord {
    
    var serviceIsActive = false
    var readAllHasCompleted: Bool = false
    var readType: Int = 0
    var readIndex: Int = 0
}

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
