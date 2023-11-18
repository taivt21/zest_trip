import UIKit
import Flutter
import GoogleMaps  // Add this import
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FlutterConfigPlugin.env(for: "API_KEY")
    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyDRohqsJ3uY_bpfD9VGClxbXHp73_dhgq0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
