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
        
        print("calling handler")
        if call.method == "requestPermissions" {
            self.requestPermissions(call, result: result)
        }
        
        if call.method == "getDataBatch" {
            self.getDataBatch(call, result: result)
        }
    }
    
    let appleHealthUtils = AppleHealthUtils.global
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        appleHealthUtils.requestPermissions { permissionResult, error in
            result(permissionResult)
        }
    }
    
    func getDataBatch(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let params = call.arguments as? [String: Int] else {
            result(nil)
            return
        }
        
        guard let typeInt = params["type"], let type = HealthKitFetchTypes(rawValue: typeInt) else {
            result(nil)
            return
        }
        
        guard let index = params["index"] else {
            result(nil)
            return
        }
        
        appleHealthUtils.fetchData(type: type, index: index, result: { batch, error in
            do {
                result(try batch?.serializedData())
            } catch {
                result(nil)
            }
        })
    }
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: startDay)!
    }
    
    var startDay: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
}
