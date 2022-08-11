import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

class ProximityScreenLockDefault extends ProximityScreenLockPlatformInterface {
  static void registerWith(Registrar registrar) {
    // noops
  }

  @override
  Future<void> setActive(bool value) async {
    await ProximityScreenLockPlatformInterface.instance.setActive(value);
  }

  @override
  Future<bool> isProximityLockSupported() async {
    return await ProximityScreenLockPlatformInterface.instance
        .isProximityLockSupported();
  }
}
