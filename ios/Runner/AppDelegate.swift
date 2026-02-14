import Flutter
import UIKit
import GoogleMaps   // <-- ADD THIS

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // <-- ADD THIS LINE FOR GOOGLE MAPS
    GMSServices.provideAPIKey("AIzaSyBR9cNpRAYaVQFicop9BlawECkA_cLfDrc")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
