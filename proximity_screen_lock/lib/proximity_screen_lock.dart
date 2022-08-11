import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

class ProximityScreenLock {
  const ProximityScreenLock._();

  static Future<void> setActive(bool value) async {
    await ProximityScreenLockPlatformInterface.instance.setActive(value);
  }

  static Future<bool> isProximityLockSupported() async {
    return await ProximityScreenLockPlatformInterface.instance
        .isProximityLockSupported();
  }
}
