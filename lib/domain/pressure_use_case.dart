import 'dart:async';

import 'package:environment_sensors/environment_sensors.dart';

class PressureUseCase {
  StreamSubscription<double>? _stream;
  final environmentSensors = EnvironmentSensors();

  Future<void> launchListenSensor({
    required Function(double) onChange,
    required Function(String) onError,
  }) async {
    bool isExistSensor = await environmentSensors.getSensorAvailable(SensorType.Pressure);
    if (!isExistSensor){
      onError("Sensor not detected");
      return;
    }
    _stream = environmentSensors.pressure.listen(onChange);
  }

  void dispose(){
    _stream?.cancel();
  }
}