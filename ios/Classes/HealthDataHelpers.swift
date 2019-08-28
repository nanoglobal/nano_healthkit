//
import HealthKit

extension HealthDataUtils {}

extension HealthDataFetcher {
    
    // MARK: Data parsing
    
    func makeData(from samples: [HKSample]?, sampleType: HKSampleType, healthType: HealthTypes) -> HealthDataList {
        
        var dataList = HealthDataList()
        for sample: HKSample in samples ?? [] {
            
            var singleData: HealthData?
            if let workoutSample = sample as? HKWorkout {
                singleData = saveAsData(sampleType: sampleType, value: workoutSample, healthType: healthType)
            } else if let quantitySample = sample as? HKQuantitySample {
                singleData = saveAsData(sampleType: sampleType, value: quantitySample, healthType: healthType)
            } else if let categorySample = sample as? HKCategorySample {
                singleData = saveAsData(sampleType: sampleType, value: categorySample, healthType: healthType)
            }
            
            if singleData != nil {
                dataList.data.append(singleData!)
            }
        }
        return dataList
    }
    
    func makeData(from characteristicValue: Any?, characteristicType: HKCharacteristicType, healthType: HealthTypes) -> HealthDataList {
        
        var dataList = HealthDataList()
        var data = HealthData()
        data.type = healthType
        data.sampleType = characteristicType.description
        data.metadata = "\(characteristicValue ?? "")"
        dataList.data.append(data)
        return dataList
    }
    
    private func saveAsDataBase(sampleType: HKSampleType, value: HKSample, healthType: HealthTypes) -> HealthData {
        
        var data = HealthData()
        data.type = healthType
        data.sampleType = sampleType.description
        data.startDate = value.startDate.iso8601
        data.endDate = value.endDate.iso8601
        data.device = value.device?.name ?? ""
        data.metadata = jsonToString(value.metadata)
        return data
    }
    
    func saveAsData(sampleType: HKSampleType, value: HKQuantitySample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        let index = HealthDataUtils.getTypeIndex(healthType)!
        if #available(iOS 12.0, *) {
            data.count = Int64(value.count)
        }
        if let unit = HealthDataUtils.QUANTITY_TYPES[index.0].1 {
            data.quantityUnit = unit.unitString
            data.quantity = value.quantity.doubleValue(for: unit)
        }
        return data
    }
    
    func saveAsData(sampleType: HKSampleType, value: HKCategorySample, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.value = Int64(value.value)
        return data
    }
    
    func saveAsData(sampleType: HKSampleType, value: HKWorkout, healthType: HealthTypes) -> HealthData {
        
        var data = saveAsDataBase(sampleType: sampleType, value: value, healthType: healthType)
        data.totalEnergyBurned = value.totalEnergyBurned?.doubleValue(for: .joule()) ?? 0
        data.totalEnergyBurnedUnit = HKUnit.joule().unitString
        data.totalDistance = value.totalDistance?.doubleValue(for: .meter()) ?? 0
        data.totalDistanceUnit = HKUnit.meter().unitString
        data.duration = value.duration
        return data
    }
    
    private func jsonToString(_ jsonDictionary: [String: Any]?) -> String {
        
        if let jsonDictionary = jsonDictionary, let theJSONData = try? JSONSerialization.data(
            withJSONObject: jsonDictionary, options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            return theJSONText ?? ""
        }
        return ""
    }
    
    private func getAnchor(anchorKey: String) -> HKQueryAnchor? {
        
        let encoded = UserDefaults.standard.data(forKey: anchorKey)
        if encoded == nil {
            return nil
        }
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: encoded!) as? HKQueryAnchor
        return anchor
    }
    
    private func saveAnchor(anchor: HKQueryAnchor, anchorKey: String) {
        
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
        self.title = title == nil ? "error_generic_title" : title
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
