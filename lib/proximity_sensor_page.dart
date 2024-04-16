import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProximitySensorPage extends StatefulWidget {
  const ProximitySensorPage({super.key});

  @override
  State<ProximitySensorPage> createState() => _ProximitySensorPageState();
}

class _ProximitySensorPageState extends State<ProximitySensorPage> {

  String? error;
  bool isLoading = true;
  late StreamSubscription<dynamic> _streamSubscription;
  int value = 0;

  @override
  void initState() {
    super.initState();
    ProximitySensor.setProximityScreenOff(false)
      .onError((error, stackTrace) {
        setState(() {
          isLoading = false;
          this.error = error?.toString();
        });
    });
    _streamSubscription = ProximitySensor.events.listen((int event) {
      if (isLoading) {
        isLoading = false;
      }
      setState(() {
        value = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isLoading)
          ? const CircularProgressIndicator()
          : Text(
            (error == null)
                ? value.toString()
                : error!
          ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}