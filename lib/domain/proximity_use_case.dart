import 'dart:async';

import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ProximityUseCase{

  late StreamSubscription<int> _streamSubscription;

  void launchListenSensor({
    required Function(int) onChange,
    required Function(String) onError,
  }) {
    ProximitySensor.setProximityScreenOff(false)
      .onError((error, stackTrace) {
        onError(error.toString());
      });

    _streamSubscription = ProximitySensor.events.listen(onChange);
  }

  void dispose(){
    _streamSubscription.cancel();
  }
}