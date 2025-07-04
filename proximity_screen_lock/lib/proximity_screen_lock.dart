import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

class ProximityScreenLock {
  const ProximityScreenLock._();

  /// If supported, setting to `true` will active bind of screen activation to
  /// proximity sensor.
  /// When binding is active, approaching object to proximity sensor of device
  /// will de-activate screen. When removing object, screen will be activated
  ///
  /// Throws error on [Android] if proximity wake lock is not supported
  static Future<void> setActive(bool value) async {
    await ProximityScreenLockPlatformInterface.instance.setActive(value);
  }

  /// Checks if binding of screen activation to proximity sensor is supported
  static Future<bool> isProximityLockSupported() async {
    return await ProximityScreenLockPlatformInterface.instance
        .isProximityLockSupported();
  }

  /// Subscribe to a stream of proximity sensor events.
  /// `true` is emitted if proximity sensor detects something; `false` otherwise
  static Stream<bool> get proximityStates =>
      ProximityScreenLockPlatformInterface.instance.proximityStates;
}
