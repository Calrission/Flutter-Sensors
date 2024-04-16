import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeUseCase{

  late StreamSubscription<GyroscopeEvent> _streamSubscription;


  double deltaX = 0, deltaY = 0, deltaZ = 0;
  double x = 0, y = 0, z = 0;

  void launchListenSensor({
    required Function(double, double, double, double, double, double) onChange,
    required Function(String) onError,
  }) {
    _streamSubscription = gyroscopeEventStream(
        samplingPeriod: SensorInterval.gameInterval
    ).listen(
      (event){
        deltaX = event.x;
        deltaY = event.y;
        deltaZ = event.z;

        x += deltaX;
        y += deltaY;
        z += deltaZ;

        onChange(x, y, z, deltaX, deltaY, deltaZ);
      },
      onError: (error){
        onError(error.toString());
      },
      cancelOnError: true,
    );
  }

  void dispose(){
    _streamSubscription.cancel();
  }
}