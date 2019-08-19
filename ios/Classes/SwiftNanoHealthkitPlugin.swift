import Flutter
import HealthKit
import UIKit

public class SwiftNanoHealthkitPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "nano_healthkit_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftNanoHealthkitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if call.method == "requestPermissions" {
            self.requestPermissions(call, result: result)
        }
        
        if call.method == "getDataBatch" {
            self.getDataBatch(call, result: result)
        }
        
    }
    
    let appleHealthUtils = AppleHealthUtils.global
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        appleHealthUtils.requestPermissions { (permissionResult, error) in
            result(permissionResult)
        }
    }
    
    func getDataBatch(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  
        guard let params = call.arguments as? [String: Int] else {
            result(nil)
            return
        }
        
        guard let typeInt = params["type"], let type = HealthKitFetchTypes.init(rawValue: typeInt) else {
            result(nil)
            return
        }
        
        guard let index = params["index"] else {
            result(nil)
            return
        }
        
        appleHealthUtils.fetchData(type: type, index: index, result: result)
    }
    
    
    
    /*func getBasicHealthData(result: @escaping FlutterResult) {
        let dob = HealthkitReader.sharedInstance.getDOB()
        let gender = HealthkitReader.sharedInstance.getBioLogicalSex()
        HealthkitReader.sharedInstance.getLastWeightReading {
            (aWeight: Double?) in
            HealthkitReader.sharedInstance.getLastHeightReading() {
                (aHeight: Double?) in
                var dic = [String: Any]()
                if dob != nil {
                    dic["dob"] = dob!.description
                }
                if gender != nil {
                    dic["gender"] = gender!.asServerParam
                }
                
                if aWeight != nil {
                    dic["weight"] = aWeight!
                }
                
                if aHeight != nil {
                    dic["height"] = aHeight!
                }
                result(dic)
            }
        }
    }
    
    func getActivity(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let params = call.arguments as? [String: String] else {
            result(nil)
            return
        }
        
        guard let metric = params["name"] else {
            result(nil)
            return
        }
        
        guard let units = params["units"] else {
            result(nil)
            return
        }
        
        var type: HKQuantityTypeIdentifier
        switch metric {
        case "steps":
            type = HKQuantityTypeIdentifier.stepCount
        case "cycling":
            type = HKQuantityTypeIdentifier.distanceCycling
        case "walkRun":
            type = HKQuantityTypeIdentifier.distanceWalkingRunning
        case "flights":
            type = HKQuantityTypeIdentifier.flightsClimbed
        case "heartRate":
            type = HKQuantityTypeIdentifier.heartRate
        default:
            result(["errorCode": "4040", "error": "unsupported type"])
            return
        }
        
        HealthkitReader.sharedInstance.requestHealthAuthorization() { success in
            HealthkitReader.sharedInstance.getHealthDataValue(type: type, strUnitType: units) { results in
                if let data = results {
                    var value: Double = 0
                    if data.count > 0 {
                        for result in data {
                            value += Double(result["value"] as! String)!
                        }
                        let dic: [String: Any] = ["name": metric, "value": value, "units": units]
                        result(dic)
                        return
                    }
                }
                result([])
            }
        }
    }*/
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: startDay)!
    }
    
    var startDay: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
}
