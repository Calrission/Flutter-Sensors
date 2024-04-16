import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';

class LightSensorPage extends StatefulWidget {
  const LightSensorPage({super.key});

  @override
  State<LightSensorPage> createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {

  bool isError = false;
  bool isLoading = true;
  int valueLight = 0;

  @override
  void initState() {
    super.initState();
    LightSensor.hasSensor().then((value) {
      setState(() {
        isLoading = false;
        isError = !value;
      });

      if (value){
        LightSensor.luxStream().listen((event) {
          setState(() {
            valueLight = event;
          });
        });
      }
    });
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