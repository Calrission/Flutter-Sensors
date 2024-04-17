import 'package:flutter/material.dart';
import 'package:sensor_project/presentation/accelerometer_page.dart';
import 'package:sensor_project/presentation/avatar_page.dart';
import 'package:sensor_project/presentation/map_page.dart';
import 'package:sensor_project/presentation/gyroscope_page.dart';
import 'package:sensor_project/presentation/humidity_page.dart';
import 'package:sensor_project/presentation/proximity_sensor_page.dart';
import 'package:sensor_project/presentation/pressure_sensor_page.dart';
import 'package:sensor_project/presentation/svg_page.dart';
import 'package:sensor_project/presentation/temp_page.dart';

import 'light_sensor_page.dart';
import 'magnetometer_page.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
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
                  child: const Text("Гироскоп")
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
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const TempSensorPage());
                  },
                  child: const Text("Датчик окружающей температуры")
              ),
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const HumiditySensorPage());
                  },
                  child: const Text("Датчик влажности")
              ),
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const PressureSensorPage());
                  },
                  child: const Text("Датчик давления")
              ),
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const AvatarPage());
                  },
                  child: const Text("Аватар")
              ),
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const MapPage());
                  },
                  child: const Text("Карта")
              ),
              const SizedBox(height: 18),
              FilledButton(
                  onPressed: (){
                    navigateTo(const SvgPage());
                  },
                  child: const Text("SVG + PickFile")
              ),
            ],
          ),
        ),
      ),
    );
  }
}