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
    
    // MARK: Remote methods
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call)
        healthUtils.requestPermissions(for: request, result: { permissionResult, error in
            self.sendResult(target: result, response: permissionResult, error: error)
        })
    }
    
    func fetchData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthDataRequest? = deserializeArguments(call)
        healthUtils.fetchData(for: request, result: { batch, error in
            self.sendResult(target: result, response: batch, error: error)
        })
    }
    
    func filterExistingTypes(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call)
        healthUtils.filterExistingTypes(for: request, result: { filteredList, error in
            self.sendResult(target: result, response: filteredList, error: error)
        })
    }
    
    // MARK: Aux methods
    
    private func deserializeArguments<T: Message>(_ call: FlutterMethodCall) -> T? {
        
        guard let dataArgs = (call.arguments as? FlutterStandardTypedData)?.data,
            let request = try? T(serializedData: dataArgs) else {
            return nil
        }
        return request
    }
    
    private func sendResult(target: @escaping FlutterResult, response origin: Any?, error: Error?) {
        
        if error != nil {
            target(error!)
            return
        }
        var response = origin
        if let originMessage = origin as? Message {
            do {
                response = try originMessage.serializedData()
            } catch {
                target(SimpleLocalizedError("Can't serialize data to send"))
                return
            }
        }
        target(response)
    }
}
