import 'package:flutter/material.dart';
import 'package:sensor_project/domain/magnetometer_use_case.dart';

class MagnetometerPage extends StatefulWidget {
  const MagnetometerPage({super.key});

  @override
  State<MagnetometerPage> createState() => _MagnetometerPageState();
}

class _MagnetometerPageState extends State<MagnetometerPage> {

  double? x, y, z;
  String? error;
  bool isLoading = true;

  MagnetometerUseCase useCase = MagnetometerUseCase();

  @override
  void initState() {
    super.initState();
    useCase.launchListenSensor(
        onChange: (event) {
          if (isLoading) {
            isLoading = false;
          }
          setState(() {
            x = event.x;
            y = event.y;
            z = event.z;
          });
        },
        onError: (error) {
          setState(() {
            isLoading = false;
            error = error.toString();
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
        child: (error == null)
          ? (isLoading)
            ? const CircularProgressIndicator()
            : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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