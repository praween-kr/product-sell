import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oninto_flutter/utils/permission/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class CurrentLocation {
  static Future<CurrentLocationData> pick() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      var status = await Permission.location.status;
      if (!status.isGranted) {
        openSettingsForPermission(
            typeText: 'location',
            purposeText: 'get current location and show map');
      }

      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    var loc = await Geolocator.getCurrentPosition();
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);

    var cl = CurrentLocationData(
      lat: loc.latitude,
      lag: loc.longitude,
      pinCode: placeMarks.first.postalCode ?? '',
      location:
          "${placeMarks.first.name} ${placeMarks.first.subLocality}, ${placeMarks.first.subAdministrativeArea}, ${placeMarks.first.street}, ${placeMarks.first.country}",
    );

    return cl;
  }
}

class CurrentLocationData {
  final double lat;
  final double lag;
  final String pinCode;
  final String location;
  CurrentLocationData(
      {required this.lat,
      required this.lag,
      required this.location,
      required this.pinCode});
}
