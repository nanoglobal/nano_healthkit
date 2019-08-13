import Flutter
import UIKit

public class SwiftNanoHealthkitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "nano_healthkit_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftNanoHealthkitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //return the name of the _channel.invokeMethod('hola_mauro') from flutter
    print(call.method)
    var book = BookInfo()
    book.id = 1
    book.title = "mauro"
    book.author = "author"
    do{
        result(try book.serializedData())
    }catch {
        
    }
    
  }
}
