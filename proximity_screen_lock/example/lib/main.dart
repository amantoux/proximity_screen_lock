import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _subsProximity;
  var _isActive = false;
  var _isSupported = false;
  var _objectDetected = false;

  @override
  void initState() {
    super.initState();
    setProximitySensorActive();
    ProximityScreenLock.isProximityLockSupported()
        .then((isSupported) => setState(() => _isSupported = isSupported));
  }

  @override
  void dispose() {
    _subsProximity?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setProximitySensorActive() async {
    try {
      await ProximityScreenLock.setActive(_isActive);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  void toggle() {
    setState(() => _isActive = !_isActive);
    setActive(_isActive);
  }

  void setActive(bool value) {
    ProximityScreenLock.setActive(value);
    _subsProximity =
        ProximityScreenLock.proximityStates.listen((objectDetected) {
      setState(() => _objectDetected = objectDetected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isSupported ? "Supported" : "Not supported",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: toggle,
                child: Text(
                  _isActive ? 'De-activate' : 'Activate',
                ),
              ),
              if (_isActive)
                Text(
                  _objectDetected ? 'Object detected' : 'No object detected',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
