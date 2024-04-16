import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopePage extends StatefulWidget {
  const GyroscopePage({super.key});

  @override
  State<GyroscopePage> createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {

  double deltaX = 0, deltaY = 0, deltaZ = 0;
  double x = 0, y = 0, z = 0;
  String? error;
  bool isLoading = true;
  StreamSubscription<GyroscopeEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = gyroscopeEventStream(
      samplingPeriod: SensorInterval.gameInterval
    ).listen(
      (GyroscopeEvent event) {
        if (isLoading) {
          isLoading = false;
        }
        setState(() {
          deltaX = event.x;
          deltaY = event.y;
          deltaZ = event.z;

          x += deltaX;
          y += deltaY;
          z += deltaZ;
        });
      },
      onError: (error) {
        setState(() {
          isLoading = false;
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
          child:
          (isLoading)
            ? const CircularProgressIndicator()
            : (error == null)
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Дельта", style: TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 18),
                      Text("X = $deltaX"),
                      const SizedBox(height: 18),
                      Text("Y = $deltaY"),
                      const SizedBox(height: 18),
                      Text("Z = $deltaZ"),
                    ],
                  ),
                  const SizedBox(width: 64),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Значения", style: TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 18),
                      Text("X = $x"),
                      const SizedBox(height: 18),
                      Text("Y = $y"),
                      const SizedBox(height: 18),
                      Text("Z = $z"),
                    ],
                  ),
                ],
              )
              : Text(error!)
      ),
    );
  }

}