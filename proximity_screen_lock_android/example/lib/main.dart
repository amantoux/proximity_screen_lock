import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_screen_lock_android/proximity_screen_lock_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _proximityScreenLock = ProximitySensorAndroid();
  var isActive = false;

  @override
  void initState() {
    super.initState();
    setProximitySensorActive();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setProximitySensorActive() async {
    try {
      await _proximityScreenLock.setActive(isActive);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  void toggle() {
    setState(() => isActive = !isActive);
    setActive(isActive);
  }

  void setActive(bool value) {
    _proximityScreenLock.setActive(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: toggle,
            child: Text(
              isActive ? 'De-activate' : 'Activate',
            ),
          ),
        ),
      ),
    );
  }
}
