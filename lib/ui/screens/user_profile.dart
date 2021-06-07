import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/clipshape_sos.dart';
import '../widgets/responsive_ui.dart';
//import 'package:flutter/gestures.dart';
//import 'package:safety_app/ui/signin.dart';
//import '../ui/widgets/textformfield.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final _form = GlobalKey<FormState>();
  bool _privacyMode = false;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Container(
        height: _height,
        width: _width,
        margin: EdgeInsets.only(bottom: 5),
        child: Column(children: <Widget>[
          // Opacity(opacity: 0.88, child: CustomAppBar()),
          ClipShapeSos(_height, _width, _medium, _large),
          Container(
            height: _height * 0.47,
            // color: Colors.blue,
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    height: _height * 0.1,
                    width: _width * 0.9,
                    // color: Colors.blue,
                    child: ListTile(
                      title: Container(
                        width: _width * 0.6,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Privacy Mode  ",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    return showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text(" What is Privacy Mode"),
                                        content: Text(
                                            "By enabling this the app will be able to access" +
                                                "the Location,calling and SMS permissions to send" +
                                                " and recieve message"),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.help,
                                    color: Colors.grey,
                                    size: 30,
                                  ))
                            ]),
                      ),
                      trailing: Switch(
                        activeColor: Colors.pink,
                        value: _privacyMode, // reflected by what the user choose
                        onChanged: (val) {
                          setState(() {
                            _privacyMode = val;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      height: _height * 0.30,
                      width: _width * 0.9,
                      // color: Colors.red,
                      child: TextField(
                          onChanged: inputMessage,
                          decoration: InputDecoration(
                            icon: Icon(Icons.edit),
                            hintText:
                                "Write some additional messages to be sent to the" +
                                    " recipients along with the location & time during an SOS",
                          ),
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: _height * 0.1,
              padding: EdgeInsets.only(left: _width * 0.2, right: _width * 0.2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "About Us",
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {},
                    ),
                    // SizedBox(width: 2),
                    RaisedButton(
                      child: Text(
                        "FAQs",
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )),
        ]));
  }

  void inputMessage(value) async {
    debugPrint(value);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("message", value);
    final _user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .set({"message": value}).catchError((onError) {
      debugPrint(onError);
    });
  }
}

// Switch(       activeColor: Colors.pink,
//               value: _privacyMode, //reflected by what the user choose
//               onChanged: (val) {
//                 setState(
//                   () {
//                     _privacyMode = val;
//                   },
//                 );
//               },
//             ),
//              FlatButton(
//                         color: Colors.black,
//                         onPressed: () {
//                           return showDialog(
//                             context: context,
//                             builder: (ctx) => AlertDialog(
//                               title: Text(" What is Privacy Mode"),
//                               content: Text(
//                      "By enabling this the app will be able to access the"+
//                      "Location,calling and SMS permissions to send and receive message"),
//                             ),
//                           );
//                         },
//                         child: Text("hmmmm")),
