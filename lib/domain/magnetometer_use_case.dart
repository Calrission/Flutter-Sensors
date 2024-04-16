import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerUseCase {
  late StreamSubscription<MagnetometerEvent> _streamSubscription;

  void launchListenSensor({
    required Function(MagnetometerEvent) onChange,
    required Function(String) onError,
  }) {
    _streamSubscription = magnetometerEventStream(
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