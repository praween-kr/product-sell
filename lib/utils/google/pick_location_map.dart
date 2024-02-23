import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'get_current_location.dart';

class PickLocationMap extends StatefulWidget {
  PickLocationMap(
      {super.key,
      required this.onChanged,
      this.cordinates,
      this.viewOnly = false});

  bool viewOnly;
  final Function(CurrentLocationData?) onChanged;
  final LatLng? cordinates;

  @override
  State<PickLocationMap> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<PickLocationMap> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng latLng = const LatLng(0.0, 0.0);
  CurrentLocationData? selectedLocation;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: Set<Marker>.of(_markers.values),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 8.0,
      ),
      myLocationEnabled: true,
      onTap: widget.viewOnly
          ? null
          : (LatLng latLng) async {
              MarkerId markerId = const MarkerId("pick");
              Marker marker = const Marker(markerId: MarkerId("pick"));
              Marker updatedMarker = marker.copyWith(
                positionParam: latLng,
              );
              ////-----------------------------
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  latLng.latitude, latLng.longitude);
              setState(() {
                _markers[markerId] = updatedMarker;
                //
                selectedLocation = CurrentLocationData(
                  lat: latLng.latitude,
                  lag: latLng.longitude,
                  pinCode: placemarks.first.postalCode ?? '',
                  location:
                      "${placemarks.first.subLocality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.street}, ${placemarks.first.postalCode}, ${placemarks.first.country}",
                );
                widget.onChanged(selectedLocation);
              });
            },
    );
  }

  getCurrentLoc() async {
    if (widget.cordinates != null) {
      latLng = widget.cordinates!;
    } else {
      CurrentLocationData currentLoc = await CurrentLocation.pick();
      debugPrint("Location : ${currentLoc.lat} ${currentLoc.lag}");
      setState(() {
        latLng = LatLng(currentLoc.lat, currentLoc.lag);
        // cameraPosition = CameraPosition(target: latLng);
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    await getCurrentLoc();
    // _completer.complete(v);
    _mapController.complete(controller);
    MarkerId markerId = const MarkerId("pick");
    LatLng position = latLng;
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      _markers[markerId] = marker;
    });

    Future.delayed(const Duration(seconds: 1), () async {
      GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 8.0),
        ),
      );
    });
  }
}
