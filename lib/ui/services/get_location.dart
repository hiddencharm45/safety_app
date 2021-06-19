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
      return null;
    });
    // code below obtains address from coordinates
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .catchError((onError) {
      debugPrint("Yo" + onError);
      return null;
    });
    // code below is to be transferred to background location fetch
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(
        'location',
        placemark[2].thoroughfare +
            ", " +
            placemark[2].subLocality +
            ", " +
            placemark[2].locality +
            "-" +
            placemark[2].postalCode);
    debugPrint('location'.toString());
    return placemark[2];
  }
}
