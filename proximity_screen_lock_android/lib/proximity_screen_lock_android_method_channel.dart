import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:proximity_screen_lock_platform_interface/proximity_screen_lock_platform_interface.dart';

/// An implementation of [ProximitySensorAndroidPlatform] that uses method channels.
class MethodChannelProximityScreenLockAndroid
    extends ProximityScreenLockPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('proximity_screen_lock_android');

  @override
  Future<void> setActive(bool value) async {
    await methodChannel.invokeMethod('setActive', value);
  }

  @override
  Future<bool> isProximityLockSupported() async {
    return await methodChannel.invokeMethod('isProximityLockSupported');
  }
}
