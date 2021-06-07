import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocation {
  Future<Placemark> locationFetch() async {
    // code below obtains current geolocation
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((onError) {
      debugPrint("Yo" + onError);
    });
    // code below obtains address from coordinates
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .catchError((onError) {
      debugPrint("Yo" + onError);
      // App data to be accessed if location is unavailable
    });
    debugPrint(placemark[2].toString());
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('location', placemark[2].toString());
    return placemark[2];
  }
}
