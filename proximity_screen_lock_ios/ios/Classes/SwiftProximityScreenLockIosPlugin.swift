import Flutter
import UIKit

private let streamHandlerName: String = "proximity_sensor_states"
private let methodChannelName: String = "proximity_screen_lock_ios"

private let setActiveMethodName: String = "setActive"
private let enableMethodName: String = "enable"

public class SwiftProximityScreenLockIosPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftProximityScreenLockIosPlugin()

    let eventChannel = FlutterEventChannel.init(name: streamHandlerName, binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)

    let channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private var eventSink: FlutterEventSink?
  private var enabled = false

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
      setActive(value)
      result(nil)
      return
    }
    result(FlutterMethodNotImplemented)
  }

  private func setActive(_ value: Bool) {
    if enabled == value { return }
    UIDevice.current.isProximityMonitoringEnabled = value
    if value {
      NotificationCenter.default.addObserver(
        forName: UIDevice.proximityStateDidChangeNotification,
        object: UIDevice.current,
        queue: nil) { [weak self] notification in
          guard let self = self, let device = notification.object as? UIDevice else { return }
          self.eventSink?(device.proximityState)
        }
    } else {
      NotificationCenter.default.removeObserver(self)
    }
    enabled = value
  }

  public func onListen(withArguments arguments: Any?,
                       eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    if enabled {
      NotificationCenter.default.removeObserver(self)
    }
    return nil
  }
}
