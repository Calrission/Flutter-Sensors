import 'package:flutter/material.dart';
import 'package:sensor_project/domain/gyroscope_use_case.dart';

class GyroscopePage extends StatefulWidget {
  const GyroscopePage({super.key});

  @override
  State<GyroscopePage> createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {

  double deltaX = 0, deltaY = 0, deltaZ = 0;
  double x = 0, y = 0, z = 0;

  GyroscopeUseCase useCase = GyroscopeUseCase();

  String? error;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    useCase.launchListenSensor(
      onChange: (x, y, z, deltaX, deltaY, deltaZ){
        if (isLoading) {
          isLoading = false;
        }
        setState(() {
          this.deltaX = deltaX;
          this.deltaY = deltaY;
          this.deltaZ = deltaZ;
          this.x = x;
          this.y = y;
          this.z = z;
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