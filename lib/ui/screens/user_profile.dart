import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:safety_app/ui/widgets/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/clipshape_sos.dart';
import '../widgets/responsive_ui.dart';
// import 'package:flutter/gestures.dart';
// import 'package:safety_app/ui/signin.dart';
// import '../ui/widgets/textformfield.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/dashboard';
  String message;
  String name;
  String email;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final _form = GlobalKey<FormState>();
  // bool _privacyMode = false;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  // String message;
  // String name;
  // String email;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  initState() {
    initializeValues();
    super.initState();
  }

  void initializeValues() async {
    // reflect the value of message in the hint text, it behaves weirdly
    SharedPreferences _pref = await SharedPreferences.getInstance();
    widget.message = _pref.getString('message');
    if (widget.message == null) widget.message = "Write additional message";

    //retrieve name and email of user here & assign to name & email variables
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
  }

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
          form(),
          // // // Container(
          // // //   height: _height * 0.47,
          // // //   // color: Colors.blue,
          // // //   child: Column(
          // // //     children: [
          // // //       Card(
          // // //         elevation: 3,
          // // //         child: Container(
          // // //           height: _height * 0.1,
          // // //           width: _width * 0.9,
          // // //           // color: Colors.blue,
          // // //           child: ListTile(
          // // //             title: Container(
          // // //               width: _width * 0.6,
          // // //               child: Row(
          // // //                   mainAxisAlignment: MainAxisAlignment.start,
          // // //                   children: <Widget>[
          // // //                     Text(
          // // //                       "Privacy Mode  ",
          // // //                       style: TextStyle(
          // // //                         fontSize: 22,
          // // //                       ),
          // // //                     ),
          // // //                     GestureDetector(
          // // //                         onTap: () {
          // // //                           return showDialog(
          // // //                             context: context,
          // // //                             builder: (ctx) => AlertDialog(
          // // //                               title: Text(" What is Privacy Mode"),
          // // //                               content: Text(
          // // //                                   "By enabling this the app will be able to access" +
          // // //                                       "the Location,calling and SMS permissions to send" +
          // // //                                       " and recieve message"),
          // // //                             ),
          // // //                           );
          // // //                         },
          // // //                         child: Icon(
          // // //                           Icons.help,
          // // //                           color: Colors.grey,
          // // //                           size: 30,
          // // //                         ))
          // // //                   ]),
          // // //             ),
          // //             trailing: Switch(
          // //               activeColor: Colors.pink,
          // //               value:
          // //                   _privacyMode, // reflected by what the user choose
          // //               onChanged: (val) {
          // //                 setState(() {
          // //                   _privacyMode = val;
          // //                 });
          // //               },
          // //             ),
          // //           ),
          // //         ),
          // //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 20),
          //         child: Card(
          //           elevation: 3,
          //           child: Container(
          //             // height: _height * 0.30,
          //             // width: _width * 0.9,
          //             // color: Colors.red,
          //             child: TextField(
          //                 onChanged: inputMessage,
          //                 decoration: InputDecoration(
          //                   icon: Icon(Icons.edit),
          //                   hintText: "Type a message",
          //                 ),
          //                 style: TextStyle(fontSize: 20)),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Container(
              height: _height * 0.1,
              padding: EdgeInsets.only(left: _width * 0.2, right: _width * 0.2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "About Us",
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {},
                    ),
                    // SizedBox(width: 2),
                    FlatButton(
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

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _width / 12.0),
      child: Form(
        child: Column(
          children: <Widget>[
            nameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            messageTextFormField(),
            SizedBox(height: _height / 20.0),
            // SizedBox(height: _height / 60.0),
            button(_scaffoldkey),
          ],
        ),
      ),
    );
  }

  Widget nameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: widget.name,
      textEditingController: nameController,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: widget.email,
      textEditingController: emailController,
    );
  }

  Widget messageTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.edit,
      hint: widget.message,
      textEditingController: messageController,
    );
  }

  // void inputMessage(value) async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .set({"message": value}).catchError((onError) {
  //     debugPrint(onError);
  //   });
  // }

  Widget button(GlobalKey<ScaffoldState> _scaffoldkey) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        FirebaseAuth.instance.currentUser.uid;
        SharedPreferences pref = await SharedPreferences.getInstance();
        // inputMessage(messageController.text.toString().trim());
        pref.setString("message", messageController.text.toString());
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          "name": nameController.text.toString(),
          "email": emailController.text.toString().trim(),
        }).catchError((e) {
          debugPrint(e);
          _scaffoldkey.currentState.showSnackBar(
              SnackBar(content: Text('Error Updating Profile Info')));
        });
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        //height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Update Info',
          style: TextStyle(fontSize: _large ? 16 : (_medium ? 14 : 12)),
        ),
      ),
    );
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
