import 'package:flutter/material.dart';
import 'package:sensor_project/domain/humidity_use_case.dart';

class HumiditySensorPage extends StatefulWidget {
  const HumiditySensorPage({super.key});

  @override
  State<HumiditySensorPage> createState() => _HumiditySensorPageState();
}

class _HumiditySensorPageState extends State<HumiditySensorPage> {
  String? error;
  bool isLoading = true;
  double humidity = 0;

  HumidityUseCase useCase = HumidityUseCase();

  late double screenHeight;

  @override
  void initState() {
    super.initState();
    useCase.launchListenSensor(
      onChange: (value){
        setState(() {
          isLoading = false;
          humidity = value;
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
  void dispose() {
    super.dispose();
    useCase.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.blueAccent,
              width: double.infinity,
              height: screenHeight * (humidity / 100),
            ),
          ),
        ),
        Center(
          child: (isLoading)
            ? const CircularProgressIndicator()
            : (error != null)
                ? Text(error!)
                : Text(
                    humidity.toString(),
                    style: const TextStyle(
                        fontSize: 42,
                        color: Colors.blueAccent,
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
                    )
                  ),
        ),
    ]));
  }
}
