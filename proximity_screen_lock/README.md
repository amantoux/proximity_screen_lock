# Proximity Screen Lock

[![pub package](https://img.shields.io/pub/v/proximity_screen_lock.svg)](https://pub.dartlang.org/packages/proximity_screen_lock)

A Flutter plugin that can be used to bind screen activation to proximity sensor and detect proximity events

# Usage

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true);
  ProximityScreenLock.proximityStates.listen((objectDetected) async {
    print(objectDetected ? 'Object detected' : 'No object detected');
  });
}
```

# Availability

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices

|                            | iOS   | Android | Others     |
|----------------------------|-------|---------|-------------|
| `isProximityLockAvailable` |  `true`   | `true` or `false`       | `false` |

