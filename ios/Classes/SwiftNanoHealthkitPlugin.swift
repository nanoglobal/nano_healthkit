//
import Flutter
import HealthKit
import SwiftProtobuf
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
        
        if call.method == "fetchData" {
            self.fetchData(call, result: result)
        }
        
        if call.method == "filterExistingTypes" {
            self.filterExistingTypes(call, result: result)
        }
    }
    
    let healthUtils = HealthDataUtils.global
    
    func deserializeArguments<T: Message>(_ call: FlutterMethodCall) -> T? {
        
        guard let dataArgs = (call.arguments as? FlutterStandardTypedData)?.data,
            let request = try? T(serializedData: dataArgs) else {
            return nil
        }
        return request
    }
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call)
        healthUtils.requestPermissions(for: request, result: { permissionResult, error in
            
            if error != nil {
                result(error!)
                return
            }
            result(permissionResult)
        })
    }
    
    func fetchData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthDataRequest? = deserializeArguments(call)
        healthUtils.fetchData(for: request, result: { batch, error in
            
            if error != nil {
                result(error!)
                return
            }
            do {
                result(try batch?.serializedData())
            } catch {
                result(SimpleLocalizedError("Cant serialize data to send"))
            }
        })
    }
    
    func filterExistingTypes(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call)
        healthUtils.filterExistingTypes(for: request, result: { filteredList, error in
            
            if error != nil {
                result(error!)
                return
            }
            result(filteredList)
        })
    }
}
