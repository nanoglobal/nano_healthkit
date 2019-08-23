//
import Flutter
import HealthKit
import UIKit
import SwiftProtobuf

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
        
        guard let request: HealthTypeList = deserializeArguments(call) else {
            result(nil)
            return
        }
        
        healthUtils.requestPermissions(for: request, completion: { permissionResult, error in
            result(permissionResult)
        })
    }
    
    func fetchData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let request: HealthDataRequest = deserializeArguments(call) else {
            result(nil)
            return
        }
        
        healthUtils.fetchData(request: request, result: { batch, error in
            do {
                result(try batch?.serializedData())
            } catch {
                result(nil)
            }
        })
    }
}
