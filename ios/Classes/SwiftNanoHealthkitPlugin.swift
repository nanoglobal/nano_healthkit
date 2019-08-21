//
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
        
        guard let dataArgs = (call.arguments as? FlutterStandardTypedData)?.data, let request = try? HealthKitDataBatchRequest(serializedData: dataArgs) else {
            result(nil)
            return
        }
        
        appleHealthUtils.fetchData(request: request, result: { batch, error in
            do {
                result(try batch?.serializedData())
            } catch {
                result(nil)
            }
        })
    }
}
