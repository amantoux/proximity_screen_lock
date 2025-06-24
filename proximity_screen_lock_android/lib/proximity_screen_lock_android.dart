import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

import 'proximity_screen_lock_android_method_channel.dart';

class ProximityScreenLockAndroid extends ProximityScreenLockPlatformInterface {
  static void registerWith() {
    ProximityScreenLockPlatformInterface.instance =
        MethodChannelProximityScreenLockAndroid();
  }

  /// Throws an error if proximity wake lock no supported
  @override
  Future<void> setActive(bool value) {
    return ProximityScreenLockPlatformInterface.instance.setActive(value);
  }

  @override
  Future<bool> isProximityLockSupported() async {
    return await ProximityScreenLockPlatformInterface.instance
        .isProximityLockSupported();
  }

  @override
  Stream<bool> get proximityStates =>
      ProximityScreenLockPlatformInterface.instance.proximityStates;
}
