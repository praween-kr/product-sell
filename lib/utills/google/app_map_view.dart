import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/utills/google/get_current_location.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({super.key});

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  final Completer<GoogleMapController> _completer = Completer();
  LatLng latLng = const LatLng(0.0, 0.0);
  Marker marker = const Marker(markerId: MarkerId("selected location"));
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(0.0, 0.0));

  getCurrentLoc() async {
    CurrentLocationData currentLoc = await CurrentLocation.pick();
    print("Location : ${currentLoc.lat} ${currentLoc.lag}");
    setState(() {
      latLng = LatLng(currentLoc.lat, currentLoc.lag);
      cameraPosition = CameraPosition(target: latLng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      initialCameraPosition: cameraPosition,
      mapType: MapType.normal,
      markers: {
        Marker(
            markerId: const MarkerId("destination"),
            position: latLng,
            infoWindow: const InfoWindow(title: "Selected Location")),
      },
      onMapCreated: (v) async {
        await getCurrentLoc();
        _completer.complete(v);
      },
      // onCameraMove: (CameraPosition position) {
      //   Marker updatedMarker = marker.copyWith(
      //     positionParam: position.target,
      //   );
      //   setState(() {
      //     marker = updatedMarker;
      //   });
      // },
    );
  }
}
