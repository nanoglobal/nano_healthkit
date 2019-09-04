//
import Flutter
import HealthKit
import SwiftProtobuf
import UIKit

public class SwiftNanoHealthkitPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let instance = SwiftNanoHealthkitPlugin()
        
        let methodChannel = FlutterMethodChannel(name: "nano_healthkit_plugin", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        
        let eventChannel = FlutterEventChannel(name: "nano_healthkit_plugin_stream", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
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
        
        if call.method == "unsubscribeToUpdates" {
            self.unsubscribeToUpdates(call, result: result)
        }
    }
    
    private let healthUtils = HealthDataUtils.global
    private var eventSink: FlutterEventSink?
    
    // MARK: Remote methods
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call.arguments)
        healthUtils.requestPermissions(for: request, result: { permissionResult, error in
            self.sendResult(target: result, response: permissionResult, error: error)
        })
    }
    
    func fetchData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthDataRequest? = deserializeArguments(call.arguments)
        healthUtils.fetchData(for: request, result: { batch, error in
            self.sendResult(target: result, response: batch, error: error)
        })
    }
    
    func filterExistingTypes(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call.arguments)
        healthUtils.filterExistingTypes(for: request, result: { filteredList, error in
            self.sendResult(target: result, response: filteredList, error: error)
        })
    }
    
    func unsubscribeToUpdates(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        healthUtils.unsubscribeToUpdates(result: { unsubscribeResponse, error in
            self.sendResult(target: result, response: unsubscribeResponse, error: error)
        })
    }
    
    // MARK: Subscription methods
    
    // It wont respond anything unless something went wrong and there is an exception
    func subscribeToUpdates(withArguments arguments: Any?) {
        
        let request: HealthTypeList? = deserializeArguments(arguments)
        healthUtils.subscribeToUpdates(for: request) { subscribeResult, error in
            if error != nil, let eventSink = self.eventSink {
                self.sendResult(target: eventSink, response: nil, error: error)
            }
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        subscribeToUpdates(withArguments: arguments)
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    @objc func sendUpdateEvent(update: Any?, error: Error?) {
        guard let eventSink = eventSink else {
            return
        }
        sendResult(target: eventSink, response: update, error: error)
    }
    
    // MARK: Aux methods
    
    private func deserializeArguments<T: Message>(_ arguments: Any?) -> T? {
        
        guard let dataArgs = (arguments as? FlutterStandardTypedData)?.data,
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
