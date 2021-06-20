import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:safety_app/ui/services/get_location.dart';
import 'package:safety_app/ui/widgets/sms_format.dart';
import 'package:safety_app/ui/widgets/sos_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_shape.dart';
import 'package:telephony/telephony.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class ClipShapeSos extends StatefulWidget {
  final double height;
  final double width;
  final bool medium;
  final bool large;

  ClipShapeSos(this.height, this.width, this.medium, this.large);

  @override
  _ClipShapeSosState createState() => _ClipShapeSosState();
}

class _ClipShapeSosState extends State<ClipShapeSos> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: widget.large
                  ? widget.height / 4
                  : (widget.medium
                      ? widget.height / 3.75
                      : widget.height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: widget.large
                  ? widget.height / 4.5
                  : (widget.medium ? widget.height / 4.25 : widget.height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: widget.large
                  ? widget.height / 30
                  : (widget.medium ? widget.height / 25 : widget.height / 20)),
          child: Container(
            height: widget.height / 3.5,
            width: widget.width / 3.5,
            child: RaisedButton(
              splashColor: Colors.black54,
              elevation: 20,
              onPressed: _sendSOS,
              shape: CircleBorder(),
              color: Colors.red,
              child: Text(
                'SOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

void _sendSOS() async {
  Placemark placemark = await GetLocation().locationFetch();
  try {
    SOSEntry().storeLocation(placemark);
  } catch (e) {
    debugPrint("Ghaplaaaaaaaaaaaaaaaa");
  }
  debugPrint(placemark.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  final telephony = Telephony.instance;
  String formattedMessage; //
  (placemark == null)
      ? formattedMessage =
          await SMSFormat().smsFormat(placemark, pref.getString('location'))
      : formattedMessage = await SMSFormat().smsFormat(placemark);
  int count;
  try {
    count = pref.getInt('count');
    debugPrint(count.toString());
    if (count == null || count == 0)
      debugPrint("No recipients added");
    else {
      for (int i = 1; i <= count; i++) {
        debugPrint(pref.getString('num' + i.toString()));
        telephony
            .sendSms(
          to: pref.getString('num' + i.toString()),
          message: formattedMessage,
        )
            // isMultipart: true)
            .catchError((onError) {
          debugPrint("Yo" + onError.toString());
        });
      }
    }
  } catch (error) {
    debugPrint("Yo Yo " + error.toString());
  }
}
