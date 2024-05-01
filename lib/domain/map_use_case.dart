import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapUseCase {
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

  Future<void> geocodePoint(
    Point point,
    {
      required Function(String) onResponse,
      required Function(String) onError
    }
  ) async {
    var response = await YandexSearch.searchByPoint(
      point: point,
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false
      )
    );
    var result = await response.$2;
    var firstResult = result.items?.firstOrNull?.toponymMetadata?.address.formattedAddress;
    if (firstResult == null){
      onError("Not fount geocode point");
      return;
    }
    onResponse(firstResult);
  }
}