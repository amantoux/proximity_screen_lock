# Proximity Screen Lock

[![pub package](https://img.shields.io/pub/v/proximity_screen_lock.svg)](https://pub.dartlang.org/packages/proximity_screen_lock)

A Flutter plugin that can be used to bind screen activation to proximity sensor

# Usage

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true)
}
```

# Availability

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices

|                            | iOS   | Android | Others     |
|----------------------------|-------|---------|-------------|
| `isProximityLockAvailable` |  `true`   | `true` or `false`       | `false` |


