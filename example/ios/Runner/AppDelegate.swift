import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let BLE_STATE_REPORT_CHANNEL = "com.ltmm.ble/blestatus"
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let bleStreamHandler = BLEStatusStreamHandler()
        let bleStatusChannel = FlutterEventChannel(name: BLE_STATE_REPORT_CHANNEL, binaryMessenger: controller.binaryMessenger)
        bleStatusChannel.setStreamHandler(bleStreamHandler)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
