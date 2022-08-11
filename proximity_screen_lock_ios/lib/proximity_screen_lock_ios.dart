import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

import 'proximity_screen_lock_ios_method_channel.dart';

class ProximityScreenLockIos extends ProximityScreenLockPlatformInterface {
  static void registerWith() {
    ProximityScreenLockPlatformInterface.instance =
        MethodChannelProximityScreenLockIos();
  }

  Future<void> setActive(bool value) async {
    ProximityScreenLockPlatformInterface.instance.setActive(value);
  }

  Future<bool> isProximityLockSupported() async {
    return await ProximityScreenLockPlatformInterface.instance
        .isProximityLockSupported();
  }
}
