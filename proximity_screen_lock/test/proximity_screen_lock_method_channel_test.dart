import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_screen_lock/proximity_screen_lock_method_channel.dart';

void main() {
  MethodChannelProximityScreenLock platform = MethodChannelProximityScreenLock();
  const MethodChannel channel = MethodChannel('proximity_screen_lock');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
