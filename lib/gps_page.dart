import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsPage extends StatefulWidget {
  const GpsPage({super.key});

  @override
  State<GpsPage> createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {

  bool isError = false;

  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    isError = !(await Geolocator.isLocationServiceEnabled()) ||
              permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever;

    if (isError){
      setState(() {});
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Position? lastPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        lastPosition = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isError) ? const Text("Ошибка") : Text(
          "longitude=${lastPosition?.longitude}\n"
          "latitude=${lastPosition?.latitude}",
        ),
      )
    );
  }
}