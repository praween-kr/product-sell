import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/utils/google/get_current_location.dart';

class AppMapView extends StatefulWidget {
  AppMapView({super.key, this.initialLatLong});
  LatLng? initialLatLong;

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  final Completer<GoogleMapController> _completer = Completer();
  LatLng latLng = const LatLng(0.0, 0.0);
  Marker marker = const Marker(markerId: MarkerId("selected location"));
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(0.0, 0.0), zoom: 8.0);

  getCurrentLoc() async {
    CurrentLocationData currentLoc = await CurrentLocation.pick();
    print("Location : ${currentLoc.lat} ${currentLoc.lag}");
    // setState(() {
    //   latLng = LatLng(currentLoc.lat, currentLoc.lag);
    //   cameraPosition = CameraPosition(target: latLng);
    // });
    setState(() {
      if (widget.initialLatLong != null) {
        setState(() {
          latLng = LatLng(widget.initialLatLong?.latitude ?? 0.0,
              widget.initialLatLong?.longitude ?? 0.0);
          cameraPosition = CameraPosition(target: latLng);
        });
      }
    });
  }

  Future<void> _goToTheLake(LatLng ll) async {
    final GoogleMapController controller = await _completer.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: ll, zoom: 8.0)));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // padding: const EdgeInsets.only(bottom: 100),
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
          infoWindow: const InfoWindow(title: "Selected Location"),
          // icon: BitmapDescriptor(),
        ),
      },
      onMapCreated: (v) async {
        await getCurrentLoc();

        _completer.complete(v);
        await _goToTheLake(latLng);
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
