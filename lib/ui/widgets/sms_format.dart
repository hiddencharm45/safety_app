// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SMSFormat {
  Future<String> smsFormat(Placemark placemark, [String location]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String dateTime =
        DateFormat('dd-MM-yyyy kk:mm:ss').format(DateTime.now()).toString();
    // final _userData = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .get()
    //     .catchError((onError) => {debugPrint("Lololol " + onError)});
    // debugPrint("THIS IS " + _userData['name'].toString());
    String formattedLocation;

    (placemark == null)
        ? formattedLocation = pref.getString('location')
        : formattedLocation = placemark.thoroughfare +
            ", " +
            placemark.subLocality +
            ", " +
            placemark.locality +
            "-" +
            placemark.postalCode;

    String customText = pref.getString('message');
    if (customText == null) customText = "(No additional message added)";
    debugPrint(customText);

    try {
      String formattedMessage = "This SOS message is sent by " +
          "whatever" + // _userData['name'] +
          " from " +
          formattedLocation +
          " at " +
          dateTime.toString() +
          "\n\n" +
          customText;

      debugPrint("Lol " + formattedMessage);
      return formattedMessage;
    } catch (e) {
      debugPrint("Haha " + e.toString());
      return formattedLocation;
    }
  }
}
