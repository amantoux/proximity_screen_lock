# Proximity Screen Lock
A Flutter plugin that de-activates the screen when proximity sensor detects somrthing

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true)
}
```

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices

