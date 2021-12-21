import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let bleStateChannel = FlutterMethodChannel(name: "bleState.fetch.flutter/state",
                                                 binaryMessenger: controller.binaryMessenger)
      bleStateChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          guard call.method == "bleState" else {
              result(FlutterMethodNotImplemented)
              return
          }
          self?.receiveBLEStatus(result: result)
      })
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBLEStatus(result: FlutterResult){
        result("gnome")
    }
}
