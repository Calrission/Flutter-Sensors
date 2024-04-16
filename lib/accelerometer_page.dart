import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({super.key});

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  double x = 0, y = 0, z = 0;
  String? error;
  bool isLoading = true;
  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEventStream(
        samplingPeriod: SensorInterval.gameInterval
    ).listen(
        (AccelerometerEvent event) {
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
        isLoading = false;
        setState(() {
          this.error = error.toString();
        });
      },
      cancelOnError: true,
    );
  }


  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
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