import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';

class HumiditySensorPage extends StatefulWidget {
  const HumiditySensorPage({super.key});

  @override
  State<HumiditySensorPage> createState() => _HumiditySensorPageState();
}

class _HumiditySensorPageState extends State<HumiditySensorPage> {

  bool isError = false;
  bool isLoading = true;
  double humidity = 0;
  StreamSubscription<double>? _stream;
  final environmentSensors = EnvironmentSensors();

  @override
  void initState() {
    super.initState();
    environmentSensors.getSensorAvailable(SensorType.Humidity).then((value) {
      setState(() {
        isLoading = false;
        isError = !value;
      });

      if (value){
        _stream = environmentSensors.humidity.listen((event) {
          setState(() {
            humidity = event;
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
                ? const Text("Датчик влажности не обнаружен")
                : Text(humidity.toString()),
        )
    );
  }
}