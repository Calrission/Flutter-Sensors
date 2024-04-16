import 'package:flutter/material.dart';
import 'package:sensor_project/domain/light_use_case.dart';

class LightSensorPage extends StatefulWidget {
  const LightSensorPage({super.key});

  @override
  State<LightSensorPage> createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {

  String? error;
  bool isLoading = true;
  double valueLight = 0;

  LightUseCase useCase = LightUseCase();

  @override
  void initState() {
    super.initState();

    useCase.launchListenSensor(
      onChange: (value){
        setState(() {
          isLoading = false;
          valueLight = value;
        });
      },
      onError: (error){
        setState(() {
          isLoading = false;
          this.error = error;
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
    var colorChannel = (valueLight / 40000 * 255).toInt();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, colorChannel, colorChannel, colorChannel),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : (error != null)
            ? Center(child: Text(error!))
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