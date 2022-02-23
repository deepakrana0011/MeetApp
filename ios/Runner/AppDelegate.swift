import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var eventChannel: FlutterEventChannel?
    
    private var url: String?
    private var methodChanel: FlutterMethodChannel?
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBx9yh9s0elbP7rotXMLC5-CvPdGLr52io")
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        methodChanel = FlutterMethodChannel(name: "method_channal", binaryMessenger: controller.binaryMessenger)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    override  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return false
        }
        
        self.url = userActivity.webpageURL?.absoluteString
        if let url = url {
            self.methodChanel?.invokeMethod("onTap", arguments: url)
            self.url = nil
        }
        return true
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        if let url = url {
            self.methodChanel?.invokeMethod("onTap", arguments: url)
            self.url = nil
        }
    }
    
}



