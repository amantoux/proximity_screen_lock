import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';
import 'package:proximity_screen_lock/proximity_screen_lock_platform_interface.dart';
import 'package:proximity_screen_lock/proximity_screen_lock_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProximityScreenLockPlatform 
    with MockPlatformInterfaceMixin
    implements ProximityScreenLockPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProximityScreenLockPlatform initialPlatform = ProximityScreenLockPlatform.instance;

  test('$MethodChannelProximityScreenLock is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProximityScreenLock>());
  });

  test('getPlatformVersion', () async {
    ProximityScreenLock proximityScreenLockPlugin = ProximityScreenLock();
    MockProximityScreenLockPlatform fakePlatform = MockProximityScreenLockPlatform();
    ProximityScreenLockPlatform.instance = fakePlatform;
  
    expect(await proximityScreenLockPlugin.getPlatformVersion(), '42');
  });
}
