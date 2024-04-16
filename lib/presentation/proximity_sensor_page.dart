import 'package:flutter/material.dart';
import 'package:sensor_project/domain/proximity_use_case.dart';

class ProximitySensorPage extends StatefulWidget {
  const ProximitySensorPage({super.key});

  @override
  State<ProximitySensorPage> createState() => _ProximitySensorPageState();
}

class _ProximitySensorPageState extends State<ProximitySensorPage> {

  String? error;
  bool isLoading = true;
  int value = 0;
  ProximityUseCase useCase = ProximityUseCase();

  @override
  void initState() {
    super.initState();
    useCase.launchListenSensor(
      onChange: (value){
        setState(() {
          isLoading = false;
          this.value = value;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isLoading)
          ? const CircularProgressIndicator()
          : Text(
            (error == null)
              ? value.toString()
              : error!
          ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    useCase.dispose();
  }
}