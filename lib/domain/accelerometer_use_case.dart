import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerUseCase{

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  void launchListenSensor({
    required Function(AccelerometerEvent) onChange,
    required Function(String) onError,
  }) {
    _streamSubscription = accelerometerEventStream(
        samplingPeriod: SensorInterval.gameInterval
    ).listen(
      onChange,
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