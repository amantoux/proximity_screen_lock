# Proximity Screen Lock for Android

A Flutter plugin that can be used to bind screen activation to proximity sensor and detect proximity events.

To activate the behavior

```dart
if (ProximityLockScreen.isProximityLockSupported()) {
  ProximityLockScreen.setActive(true);
  ProximityScreenLock.proximityStates.listen((objectDetected) async {
    print(objectDetected ? 'Object detected' : 'No object detected');
  });
}
```

`ProximityLockScreen.isProximityLockAvailable()` will return `false` on Android devices that do not provide a proximity sensor.
It will also return `false` for non-mobile devices

