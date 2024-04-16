import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensor_project/domain/gps_use_case.dart';

class GpsPage extends StatefulWidget {
  const GpsPage({super.key});

  @override
  State<GpsPage> createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {

  GpsUseCase useCase = GpsUseCase();
  String? error;

  double? latitude, longitude;

  @override
  void initState() {
    super.initState();
    useCase.getCurrentLocation(
      onResponse: (position) {
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
      },
      onError: (error){
        setState(() {
          this.error = error;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (error != null)
          ? const Text("Ошибка")
          : Text(
            "longitude=$longitude\n"
            "latitude=$latitude",
          ),
      )
    );
  }
}