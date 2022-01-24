import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
private var eventChannel: FlutterEventChannel?

  private let linkStreamHandler = LinkStreamHandler()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   let controller = window.rootViewController as! FlutterViewController
      eventChannel = FlutterEventChannel(
      name: "poc.deeplink.flutter.dev/events", binaryMessenger: controller as! FlutterBinaryMessenger)

    GMSServices.provideAPIKey("AIzaSyBx9yh9s0elbP7rotXMLC5-CvPdGLr52io")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class LinkStreamHandler:NSObject, FlutterStreamHandler {

  var eventSink: FlutterEventSink?

  // links will be added to this queue until the sink is ready to process them
  var queuedLinks = [String]()

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }

  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}
