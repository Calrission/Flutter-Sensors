import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerPage extends StatefulWidget {
  const MagnetometerPage({super.key});

  @override
  State<MagnetometerPage> createState() => _MagnetometerPageState();
}

class _MagnetometerPageState extends State<MagnetometerPage> {

  double? x, y, z;
  String? error;
  bool isLoading = true;
  StreamSubscription<MagnetometerEvent>? _streamSubscription;


  @override
  void initState() {
    super.initState();
    _streamSubscription = magnetometerEventStream().listen(
      (MagnetometerEvent event) {
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