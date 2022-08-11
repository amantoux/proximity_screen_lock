import Flutter
import UIKit

public class SwiftProximityScreenLockIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "proximity_screen_lock_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftProximityScreenLockIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "setActive" {
      guard let value = call.arguments as? Bool else {
        result(FlutterError(
          code: "ProximityScreenLockPlugin",
          message: "Argument may only be a boolean",
          details: nil)
        )
        return
      }
      UIDevice.current.isProximityMonitoringEnabled = value
      result(nil)
      return
    }
    result(FlutterMethodNotImplemented)
  }
}
