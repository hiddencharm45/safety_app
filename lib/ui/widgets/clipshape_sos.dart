import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:safety_app/ui/services/get_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_shape.dart';
import 'package:telephony/telephony.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;

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
  // StreamSubscription<HardwareButtons.VolumeButtonEvent> _volumeButtonSub;
  // @override
  // void initState() {
  //   super.initState();
  //   _volumeButtonSub =
  //       HardwareButtons.volumeButtonEvents.listen((VolumeButtonEvent event) {
  //     setState(() {
  //       print("THIS IS BUTTON EVENT: " + event.toString());
  //     });
  //     print(_volumeButtonSub.toString());
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _volumeButtonSub?.cancel();
  // }

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
  // code below sends the location to the recipients as sms
  final telephony = Telephony.instance;
  SharedPreferences pref = await SharedPreferences.getInstance();
  // Retrieving contacts from Firestore
  // final _user = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection('contact').doc(_user.uid).get().then((querySnapshot) {});
  try {
    int count = pref.getInt('count');
    if (count == 0) debugPrint("No recipients added");
    for (int i = 1; i <= count; i++)
      telephony
          .sendSms(
              to: pref.getString('num' + i.toString()),
              message: placemark.toString(),
              isMultipart: true)
          .catchError((onError) {
        print("Yo" + onError);
      });
  } catch (e) {
    debugPrint("No recipients added");
  }

  // opens the message app but doesn't send it automatically
  // List<String> recipients = ['+917278419247', '+917278705235'];
  // String result =
  //     await sendSMS(message: placemark[2].toString(), recipients: recipients)
  //         .catchError((onError) {
  //   debugPrint(onError.toString());
  // });
  // debugPrint(result.toString());
}
