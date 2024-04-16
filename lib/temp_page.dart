import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';

class TempSensorPage extends StatefulWidget {
  const TempSensorPage({super.key});

  @override
  State<TempSensorPage> createState() => _TempSensorPageState();
}

class _TempSensorPageState extends State<TempSensorPage> {
  
  final environmentSensors = EnvironmentSensors();
  bool isError = false;
  StreamSubscription<double>? _stream;
  bool isLoading = true;
  double temp = 0;

  @override
  void initState() {
    super.initState();
    environmentSensors.getSensorAvailable(SensorType.AmbientTemperature).then((value) {
      setState(() {
        isLoading = false;
        isError = !value;
      });

      if (value){
        _stream = environmentSensors.temperature.listen((event) {
          setState(() {
            temp = event;
          });
        });
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _stream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isLoading)
          ? const CircularProgressIndicator()
          : (isError) 
            ? const Text("Датчик температуры не обнаружен")
            : Text("$temp°")
      ),
    );
  }
}