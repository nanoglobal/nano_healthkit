//
import Flutter
import HealthKit
import SwiftProtobuf
import UIKit

public class SwiftNanoHealthkitPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    var _headlessRunner: FlutterEngine
    var _callbackChannel: FlutterMethodChannel
    var _methodChannel: FlutterMethodChannel
    var _eventChannel: FlutterEventChannel
    var _registrar: FlutterPluginRegistrar
    
    static var isInitialized = false
    static var instance: SwiftNanoHealthkitPlugin?
    static var registerPlugins: FlutterPluginRegistrantCallback?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        HealthDataUtils.addToLog("Calling register...")
        if instance == nil {
            HealthDataUtils.addToLog("... instance was nil")
            instance = SwiftNanoHealthkitPlugin(registrar: registrar)
            registrar.addApplicationDelegate(instance!)
            // instance!.restoreSubscription()
        }
    }
    
    public static func setPluginRegistrantCallback(_ callback: @escaping FlutterPluginRegistrantCallback) {
        registerPlugins = callback
    }
    
    init(registrar: FlutterPluginRegistrar) {
        
        _registrar = registrar
        
        // Register main channel
        _methodChannel = FlutterMethodChannel(name: "nano_healthkit_plugin", binaryMessenger: registrar.messenger())
        
        // Register event channel
        _eventChannel = FlutterEventChannel(name: "nano_healthkit_plugin_stream", binaryMessenger: registrar.messenger())
        
        // Create headless engine to send messages in background
        _headlessRunner = FlutterEngine(name: "nano_healthkit_plugin_headless", project: nil, allowHeadlessExecution: true)
        
        // 5. Create a second method channel to be used to communicate with the
        // callback dispatcher. This channel will be registered to listen for
        // method calls once the callback dispatcher is started.
        _callbackChannel = FlutterMethodChannel(name: "nano_healthkit_plugin_background", binaryMessenger: _headlessRunner.binaryMessenger)
        
        super.init()
        
        registrar.addMethodCallDelegate(self, channel: _methodChannel)
        _eventChannel.setStreamHandler(self)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        print("calling handler")
        HealthDataUtils.addToLog("Method called: \(call.method)")
        
        if call.method == "initialize" {
            self.initialize(call, result: result)
        }
        
        if call.method == "initialized" {
            self.initialized(call, result: result)
        }
        
        if call.method == "requestPermissions" {
            self.requestPermissions(call, result: result)
        }
        
        if call.method == "filterExistingTypes" {
            self.filterExistingTypes(call, result: result)
        }
        
        if call.method == "fetchData" {
            self.fetchData(call, result: result)
            HealthDataUtils.readLog()
        }
        
        if call.method == "unsubscribeToUpdates" {
            self.unsubscribeToUpdates(call, result: result)
        }
        
        if call.method == "fetchStatisticsData" {
            self.fetchStatisticsData(call, result: result)
        }
    }
    
    private let healthUtils = HealthDataUtils.global
    private var eventSink: FlutterEventSink?
    
    // MARK: Remote methods
    
    func initialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        startService(handle: (call.arguments as! [Int64])[0])
        sendResult(target: result, response: true, error: nil)
    }
    
    func initialized(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        SwiftNanoHealthkitPlugin.isInitialized = true
        
        // Send the geofence events that occurred while the background
        // isolate was initializing.
        /* while ([_eventQueue count] > 0) {
         	NSDictionary* event = _eventQueue[0];
         	[_eventQueue removeObjectAtIndex:0];
         	CLRegion* region = [event objectForKey:kRegionKey];
         	int type = [[event objectForKey:kEventType] intValue];
         	[self sendLocationEvent:region eventType: type];
         } */
        
        // TODO: Send saved events
        
        self.sendResult(target: result, response: true, error: nil)
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
    
    func retrieveSavedValues() -> String {
        
        let preferences = UserDefaults.standard
        let arrayKey = "backgroundReads"
        let array = preferences.stringArray(forKey: arrayKey) ?? [String]()
        return array.description
    }
    
    func unsubscribeToUpdates(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        saveSubscription(arguments: nil)
        healthUtils.unsubscribeToUpdates(result: { unsubscribeResponse, error in
            self.sendResult(target: result, response: unsubscribeResponse, error: error)
        })
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
        
        HealthDataUtils.addToLog("Sending update event")
        guard let eventSink = eventSink else {
            HealthDataUtils.addToLog("... no event sink")
            return
        }
        HealthDataUtils.addToLog("... update: \(update ?? "")")
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
        
        HealthDataUtils.addToLog("Restoring subscription")
        return HealthDataUtils.readValue(type: Data.self, key: "subscriptionSaved")
        /* guard let encoded = HealthDataUtils.readValue(type: Data.self, key: "subscriptionSaved") else {
             HealthDataUtils.addToLog("... no subscription to restore")
             return
         }
         subscribeToUpdates(withArguments: encoded) */
    }
    
    private func saveSubscription(arguments: Any?) {
        
        HealthDataUtils.addToLog("Saving subscription")
        let args = (arguments as? FlutterStandardTypedData)?.data ?? (arguments as? Data)
        HealthDataUtils.writeValue(args, key: "subscriptionSaved")
    }
    
    func startService(handle: Int64) {
        
        setCallbackDispatcherHandle(handle: handle)
        let info = FlutterCallbackCache.lookupCallbackInformation(handle)!
        _headlessRunner.run(withEntrypoint: info.callbackName, libraryURI: info.callbackLibraryPath)
        
        // Once our headless runner has been started, we need to register the application's plugins
        // with the runner in order for them to work on the background isolate. `registerPlugins` is
        // a callback set from AppDelegate.m in the main application. This callback should register
        // all relevant plugins (excluding those which require UI).
        SwiftNanoHealthkitPlugin.registerPlugins?(_headlessRunner)
        _registrar.addMethodCallDelegate(self, channel: _callbackChannel)
    }
    
    func getCallbackDispatcherHandle() -> Int64 {
        if let encoded = HealthDataUtils.readValue(type: String.self, key: "serviceHandle") {
            return Int64(encoded) ?? 0
        }
        return 0
    }
    
    func setCallbackDispatcherHandle(handle: Int64) {
        HealthDataUtils.writeValue(String(handle), key: "serviceHandle")
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
