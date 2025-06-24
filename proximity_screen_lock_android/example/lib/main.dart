import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_screen_lock_android/proximity_screen_lock_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _proximityScreenLock = ProximityScreenLockAndroid();
  StreamSubscription? _subsProximity;
  var _isActive = false;
  var _objectDetected = false;

  @override
  void initState() {
    super.initState();
    setProximitySensorActive();
  }

  @override
  void dispose() {
    _subsProximity?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setProximitySensorActive() async {
    try {
      await _proximityScreenLock.setActive(_isActive);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  void toggle() {
    setState(() => _isActive = !_isActive);
    setActive(_isActive);
  }

  void setActive(bool value) {
    _proximityScreenLock.setActive(value);
    _subsProximity =
        _proximityScreenLock.proximityStates.listen((objectDetected) {
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
            children: [
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
