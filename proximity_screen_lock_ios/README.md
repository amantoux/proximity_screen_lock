# Proximity Screen Lock for iOS

A Flutter plugin that can be used to bind screen activation to proximity sensor

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true)
}
```

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices


