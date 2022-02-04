import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
private var eventChannel: FlutterEventChannel?


    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBx9yh9s0elbP7rotXMLC5-CvPdGLr52io")
        GeneratedPluginRegistrant.register(with: self)
           return true
       }
      override  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
               guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
                   return false
               }
return true
}

}



