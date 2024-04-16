import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';
import 'package:sensor_project/domain/temp_use_case.dart';

class TempSensorPage extends StatefulWidget {
  const TempSensorPage({super.key});

  @override
  State<TempSensorPage> createState() => _TempSensorPageState();
}

class _TempSensorPageState extends State<TempSensorPage> {

  String? error;
  bool isLoading = true;
  double temp = 0;
  TempUseCase useCase = TempUseCase();

  @override
  void initState() {
    super.initState();

    useCase.launchListenSensor(
        onChange: (value){
          setState(() {
            isLoading = false;
            temp = value;
          });
        },
        onError: (error){
          setState(() {
            isLoading = false;
            this.error = error;
          });
        }
    );
  }


  @override
  void dispose() {
    super.dispose();
    useCase.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isLoading)
          ? const CircularProgressIndicator()
          : (error != null)
            ? Text(error!)
            : Text("$temp°")
      ),
    );
  }
}