import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';

class LightSensorPage extends StatefulWidget {
  const LightSensorPage({super.key});

  @override
  State<LightSensorPage> createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {

  bool isError = false;
  bool isLoading = true;
  double valueLight = 0;
  StreamSubscription<double>? _stream;
  final environmentSensors = EnvironmentSensors();

  @override
  void initState() {
    super.initState();
    environmentSensors.getSensorAvailable(SensorType.Light).then((value) {
      setState(() {
        isLoading = false;
        isError = !value;
      });

      if (value){
        _stream = environmentSensors.light.listen((event) {
          setState(() {
            valueLight = event;
          });
        });
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _stream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var colorChannel = (valueLight / 40000 * 255).toInt();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, colorChannel, colorChannel, colorChannel),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : (isError)
            ? const Center(child: Text("Датчик света не обнаружен"))
            : Center(
                child: Text(valueLight.toString(), style: const TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  inherit: true,
                    shadows: [
                      Shadow(
                          offset: Offset(-1.5, -1.5),
                          color: Colors.white
                      ),
                      Shadow(
                          offset: Offset(1.5, -1.5),
                          color: Colors.white
                      ),
                      Shadow(
                          offset: Offset(1.5, 1.5),
                          color: Colors.white
                      ),
                      Shadow(
                          offset: Offset(-1.5, 1.5),
                          color: Colors.white
                      ),
                    ]
                )),
              )
    );
  }
}