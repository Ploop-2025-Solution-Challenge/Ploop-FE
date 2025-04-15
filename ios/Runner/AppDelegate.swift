import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var gmsApiKey: String = "" 
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
GeneratedPluginRegistrant.register(with: self)

    if !gmsApiKey.isEmpty {
      GMSServices.provideAPIKey(self.gmsApiKey)
    }

    if let controller = window?.rootViewController as? FlutterViewController {
      setupMethodChannel(controller: controller)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func setupMethodChannel(controller: FlutterViewController) {
    let envChannel = FlutterMethodChannel(
      name: "com.example.ploopFe/env",
      binaryMessenger: controller.binaryMessenger
    )

    envChannel.setMethodCallHandler { [weak self] (call, result) in
      guard let self = self else { return }

      switch call.method {
      case "setGoogleMapsApiKey":
        if let args = call.arguments as? [String: String],
           let apiKey = args["gmsApiKey"] {
          self.gmsApiKey = apiKey
          GMSServices.provideAPIKey(apiKey)
          print("Google Maps API key set")
          result(true)
        } else {
          result(FlutterError(code: "INVALID_ARGS", message: "API Key not provided", details: nil))
        }

      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}