# Default Proximity Screen Lock
A Flutter plugin that can be used to bind screen activation to proximity sensor

**By default, this plugin assumes not proximity sensor is available**

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true)
}
```

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices