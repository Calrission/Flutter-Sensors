import 'package:flutter/material.dart';
import 'package:sensor_project/domain/pressure_use_case.dart';

class PressureSensorPage extends StatefulWidget {
  const PressureSensorPage({super.key});

  @override
  State<PressureSensorPage> createState() => _PressureSensorPageState();
}

class _PressureSensorPageState extends State<PressureSensorPage> {

  String? error;
  bool isLoading = true;
  double value = 0;

  PressureUseCase useCase = PressureUseCase();

  @override
  void initState() {
    super.initState();
    useCase.launchListenSensor(
        onChange: (value){
          setState(() {
            isLoading = false;
            this.value = value;
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
    useCase.dispose();
  }
}