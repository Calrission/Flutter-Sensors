import 'package:flutter/material.dart';
import 'package:sensor_project/accelerometer_page.dart';
import 'package:sensor_project/gyroscope_page.dart';
import 'package:sensor_project/light_sensor_page.dart';
import 'package:sensor_project/magnetometer_page.dart';
import 'package:sensor_project/proximity_sensor_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  void navigateTo(Widget target){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => target)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: (){
                navigateTo(const AccelerometerPage());
              },
              child: const Text("Акселерометр")
            ),
            const SizedBox(height: 18),
            FilledButton(
                onPressed: (){
                  navigateTo(const GyroscopePage());
                },
                child: const Text("Гироском")
            ),
            const SizedBox(height: 18),
            FilledButton(
                onPressed: (){
                  navigateTo(const MagnetometerPage());
                },
                child: const Text("Магнетометр")
            ),
            const SizedBox(height: 18),
            FilledButton(
                onPressed: (){
                  navigateTo(const LightSensorPage());
                },
                child: const Text("Датчик освещенности")
            ),
            const SizedBox(height: 18),
            FilledButton(
                onPressed: (){
                  navigateTo(const ProximitySensorPage());
                },
                child: const Text("Датчик приближения")
            ),
          ],
        ),
      ),
    );
  }
}