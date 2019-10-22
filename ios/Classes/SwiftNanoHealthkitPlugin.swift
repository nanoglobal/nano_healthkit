//
import Flutter
import HealthKit
import SwiftProtobuf
import UIKit

public class SwiftNanoHealthkitPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    static var instance: SwiftNanoHealthkitPlugin?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        if instance == nil {
            
            let instance = SwiftNanoHealthkitPlugin()
            SwiftNanoHealthkitPlugin.instance = instance
            
            // Register main channel
            let _methodChannel = FlutterMethodChannel(name: "nano_healthkit_plugin", binaryMessenger: registrar.messenger())
            registrar.addMethodCallDelegate(instance, channel: _methodChannel)
            
            // Register event channel
            let _eventChannel = FlutterEventChannel(name: "nano_healthkit_plugin_stream", binaryMessenger: registrar.messenger())
            _eventChannel.setStreamHandler(instance)
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if call.method == "initialize" {
            self.initialize(call, result: result)
        }
        
        if call.method == "requestPermissions" {
            self.requestPermissions(call, result: result)
        }
        
        if call.method == "filterExistingTypes" {
            self.filterExistingTypes(call, result: result)
        }
        
        if call.method == "fetchData" {
            self.fetchData(call, result: result)
        }
        
        if call.method == "unsubscribeToUpdates" {
            self.unsubscribeToUpdates(call, result: result)
        }
        
        if call.method == "isSubscribedToUpdates" {
            self.isSubscribedToUpdates(call, result: result)
        }
        
        if call.method == "fetchStatisticsData" {
            self.fetchStatisticsData(call, result: result)
        }
    }
    
    private let healthUtils = HealthDataUtils.global
    private var eventSink: FlutterEventSink?
    
    // MARK: Remote methods
    
    func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        sendResult(target: result, response: true, error: nil)
    }
    
    func requestPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call.arguments)
        healthUtils.requestPermissions(for: request, result: { permissionResult, error in
            self.sendResult(target: result, response: permissionResult, error: error)
        })
    }
    
    func filterExistingTypes(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthTypeList? = deserializeArguments(call.arguments)
        healthUtils.filterExistingTypes(for: request, result: { filteredList, error in
            self.sendResult(target: result, response: filteredList, error: error)
        })
    }
    
    func fetchData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: HealthDataRequest? = deserializeArguments(call.arguments)
        healthUtils.fetchData(for: request, result: { batch, error in
            self.sendResult(target: result, response: batch, error: error)
        })
    }
    
    func unsubscribeToUpdates(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        saveSubscription(arguments: nil)
        healthUtils.unsubscribeToUpdates(result: { unsubscribeResponse, error in
            self.sendResult(target: result, response: unsubscribeResponse, error: error)
        })
    }
    
    func isSubscribedToUpdates(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let isSubscribed = restoreSubscription() != nil
        self.sendResult(target: result, response: isSubscribed, error: nil)
    }
    
    func fetchStatisticsData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let request: StatisticsRequest? = deserializeArguments(call.arguments)
        healthUtils.fetchStatisticsData(for: request, result: { batch, error in
            self.sendResult(target: result, response: batch, error: error)
        })
    }
    
    // MARK: Subscription methods
    
    // It can be called with arguments or empty. If empty try to restore a subscription, otherwise dont continue
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        self.eventSink = events
        guard let arguments = arguments ?? restoreSubscription() else {
            return nil
        }
        saveSubscription(arguments: arguments)
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
    
    // It wont respond anything unless something went wrong and there is an exception
    private func subscribeToUpdates(withArguments arguments: Any?) {
        
        let request: HealthTypeList? = deserializeArguments(arguments)
        healthUtils.subscribeToUpdates(for: request, updateHandler: sendUpdateEvent(update:error:)) { subscribeResult, error in
            if error != nil, let eventSink = self.eventSink {
                self.sendResult(target: eventSink, response: nil, error: error)
            }
        }
    }
    
    private func restoreSubscription() -> Data? {
        return HealthDataUtils.readValue(type: Data.self, key: "subscriptionSaved")
    }
    
    private func saveSubscription(arguments: Any?) {
        let args = (arguments as? FlutterStandardTypedData)?.data ?? (arguments as? Data)
        HealthDataUtils.writeValue(args, key: "subscriptionSaved")
    }
    
    // MARK: Aux methods
    
    private func deserializeArguments<T: Message>(_ arguments: Any?) -> T? {
        
        let dataArgsOp: Data? = (arguments as? FlutterStandardTypedData)?.data ?? (arguments as? Data)
        guard let dataArgs = dataArgsOp, let request = try? T(serializedData: dataArgs) else {
            return nil
        }
        return request
    }
    
    private func sendResult(target: @escaping FlutterResult, response origin: Any?, error: Error?) {
        
        if error != nil {
            target(error!.convertToFlutter())
            return
        }
        var response = origin
        if let originMessage = origin as? Message {
            do {
                response = try originMessage.serializedData()
            } catch {
                target(SimpleLocalizedError("Can't serialize data to send").convertToFlutter())
                return
            }
        }
        target(response)
    }
}

extension Error {
    
    func convertToFlutter() -> FlutterError {
        
        let nserror = self as NSError
        var code = "\(nserror.code)"
        var message = nserror.domain
        if let simpleerror = (self as? SimpleLocalizedError) {
            code = "\(simpleerror.code)"
            message = (simpleerror.title?.isEmpty ?? true) ? message : simpleerror.title!
        }
        return FlutterError(code: code, message: message, details: self.localizedDescription)
    }
}
