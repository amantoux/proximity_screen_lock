import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_screen_lock/proximity_screen_lock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isActive = false;
  var isSupported = false;

  @override
  void initState() {
    super.initState();
    setProximitySensorActive();
    ProximityScreenLock.isProximityLockSupported()
        .then((isSupported) => setState(() => this.isSupported = isSupported));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setProximitySensorActive() async {
    try {
      await ProximityScreenLock.setActive(isActive);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  void toggle() {
    setState(() => isActive = !isActive);
    setActive(isActive);
  }

  void setActive(bool value) {
    ProximityScreenLock.setActive(value);
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
                isSupported ? "Supported" : "Not supported",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: toggle,
                child: Text(
                  isActive ? 'De-activate' : 'Activate',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
