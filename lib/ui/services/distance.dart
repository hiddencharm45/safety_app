// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';

class Distance {
  bool getLinearDistance(
      Coordinates userLocation, Coordinates responderLocation) {
    var R = 6371; // Radius of the earth in km
    double deg2rad(deg) {
      return deg * (pi / 180);
    }

    var dLat = deg2rad(userLocation.latitude - responderLocation.latitude);
    var dLon = deg2rad(userLocation.longitude - responderLocation.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(userLocation.latitude)) *
            cos(responderLocation.latitude) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    if (d < 1)
      return true;
    else
      return false;
  }
}
