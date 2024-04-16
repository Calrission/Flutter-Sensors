import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class PressureSensorPage extends StatefulWidget {
  const PressureSensorPage({super.key});

  @override
  State<PressureSensorPage> createState() => _PressureSensorPageState();
}

class _PressureSensorPageState extends State<PressureSensorPage> {

  final environmentSensors = EnvironmentSensors();
  String? error;
  bool isError = false;
  bool isLoading = true;
  late StreamSubscription<dynamic> _streamSubscription;
  double value = 0;

  @override
  void initState() {
    super.initState();
    environmentSensors.getSensorAvailable(SensorType.Pressure).then((value) {
      setState(() {
        isLoading = false;
        isError = !value;
      });

      if (value){
        _streamSubscription = environmentSensors.pressure.listen((event) {
          setState(() {
            this.value = event;
          });
        });
      }
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