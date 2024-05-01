import 'package:flutter/material.dart';
import 'package:sensor_project/domain/map_use_case.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  MapUseCase useCase = MapUseCase();
  String? error;

  double? latitude, longitude;

  @override
  void initState() {
    super.initState();
    useCase.getCurrentLocation(
      onResponse: (position) async {
        await useCase.geocodePoint(
          Point(
            latitude: position.latitude,
            longitude: position.longitude
          ),
          onResponse: (String address) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(address)));
          },
          onError: (String error) {
            this.error = error;
          });
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
      },
      onError: (error){
        setState(() {
          this.error = error;
        });
      }
    );
  }

  PlacemarkMapObject getMarkerCurrentLocation(){
    return PlacemarkMapObject(
        mapId: const MapObjectId("user-location"),
        point: Point(latitude: latitude!, longitude: longitude!),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage("assets/current_location.png"),
              scale: 0.2,
              anchor: const Offset(0.5, 1)
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (error != null)
          ? Text(error!)
          : (latitude != null && longitude != null)
            ? YandexMap(
              mapObjects: [getMarkerCurrentLocation()],
            )
          : const CircularProgressIndicator()
      )
    );
  }
}