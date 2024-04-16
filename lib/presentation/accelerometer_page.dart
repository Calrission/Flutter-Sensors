import 'package:flutter/material.dart';
import 'package:sensor_project/domain/accelerometer_use_case.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({super.key});

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  double x = 0, y = 0, z = 0;
  String? error;
  bool isLoading = true;

  AccelerometerUseCase useCase = AccelerometerUseCase();

  @override
  void initState() {
    super.initState();

    useCase.launchListenSensor(
      onChange: (event) {
        setState(() {
          if (isLoading) {
            isLoading = false;
          }
          x = event.x;
          y = event.y;
          z = event.z;
        });
      },
      onError: (error) {
        setState(() {
          this.error = error.toString();
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
        : (error == null)
          ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Значения", style: TextStyle(fontWeight: FontWeight.w600),),
              const SizedBox(height: 18),
              Text("X = $x"),
              const SizedBox(height: 18),
              Text("Y = $y"),
              const SizedBox(height: 18),
              Text("Z = $z"),
            ],
          )
          : Text(error!)
      ),
    );
  }
}