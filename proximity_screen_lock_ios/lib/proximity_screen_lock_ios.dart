import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

import 'proximity_screen_lock_ios_method_channel.dart';

class ProximityScreenLockIos extends ProximityScreenLockPlatformInterface {
  static void registerWith() {
    ProximityScreenLockPlatformInterface.instance =
        MethodChannelProximityScreenLockIos();
  }

  @override
  Future<void> setActive(bool value) async {
    ProximityScreenLockPlatformInterface.instance.setActive(value);
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
