import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class ProximityScreenLockPlatformInterface extends PlatformInterface {
  ProximityScreenLockPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static ProximityScreenLockPlatformInterface _instance =
      _DefaultProximityScreenLock();

  static ProximityScreenLockPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProximityScreenLockPlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(ProximityScreenLockPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// If set to `true` will de-activate screen if proximity sensor detects something
  /// For [Android], if used and *proximity wake lock* is not available, this will throw
  Future<void> setActive(bool value);

  /// Will always return `true` except for [Android] devices for which will return
  /// if *proximity wake lock* is supported
  Future<bool> isProximityLockSupported();
}

class _DefaultProximityScreenLock extends ProximityScreenLockPlatformInterface {
  @override
  Future<void> setActive(bool value) async {
    // noops
  }

  @override
  Future<bool> isProximityLockSupported() async {
    return false;
  }
}
