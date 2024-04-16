import 'package:geolocator/geolocator.dart';

class GpsUseCase {
  Future<void> getCurrentLocation(
    {
      required Function(Position) onResponse,
      required Function(String) onError
    }
  ) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (!(await Geolocator.isLocationServiceEnabled())){
      onError("Location service disable");
      return;
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever){
      onError("Permission denied");
      return;
    }

    var position = await Geolocator.getCurrentPosition();
    onResponse(position);
  }
}