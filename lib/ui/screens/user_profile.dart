import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_app/ui/widgets/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/clipshape_sos.dart';
import '../widgets/responsive_ui.dart';
// import 'package:flutter/gestures.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/dashboard';
  final String message;
  final String name;
  final String email;

  UserProfile(this.name, this.email, this.message);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  var _isLoading = false;
  String _name;
  String _email;
  String _message;

  var _initValues = {
    'name': '',
    'email': '',
    'message': '',
  };
  @override
  void initState() {
    _isLoading = true;
    getInitVal();
    super.initState();
  }

  void getInitVal() async {
    final c = collectionReference.doc(_user.uid);
    final name = await c.get().then((value) => value['name']);
    final email = await c.get().then((value) => value['email']);
    final message = await c.get().then((value) => value['message']);
    setState(() {
      _initValues = {
        'name': name.toString(),
        'email': email.toString(),
        'message': message.toString(),
      };
      // _name = name.toString();
      // _email = email.toString();
      // _message = message.toString();

      _isLoading = false;
    });
  }

  // Future<void> _updateForm() async {

  // }

  // final _form = GlobalKey<FormState>();
  // bool _privacyMode = false;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  Future<void> _saveForm() async {
    _form.currentState.save();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("message", messageController.text.toString());
    FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      "name": _name,
      "email": _email,
      "message": _message,
    }).catchError((e) {
      debugPrint(e);
      _scaffoldkey.currentState
          .showSnackBar(SnackBar(content: Text('Error Updating Profile Info')));
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: _height,
            width: _width,
            margin: EdgeInsets.only(bottom: 5),
            child: SingleChildScrollView(
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
                    padding: EdgeInsets.only(
                        left: _width * 0.2, right: _width * 0.2),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "About Us",
                              style: TextStyle(color: Colors.black87),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(" About Us"),
                                  content: Text("This app is created by" +
                                      " Ritu Jalan & Somyajit Nath" +
                                      " as their final year project for " +
                                      "engineering graduation course."),
                                ),
                              );
                            },
                          ),
                          // SizedBox(width: 2),
                          FlatButton(
                            child: Text(
                              "FAQs",
                              style: TextStyle(color: Colors.black87),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("FAQs"),
                                  content: Text("This will be added later on"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
              ]),
            ));
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _width / 12.0),
      child: Form(
        key: _form,
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
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large ? 12 : (_medium ? 10 : 8),
      child: TextFormField(
        initialValue: _initValues['name'],
        keyboardType: TextInputType.text,
        onSaved: (value) {
          _name = value;
        },
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.black45, size: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
    // return CustomTextField(
    //   initialValue: _initValues['name'],
    //   keyboardType: TextInputType.text,
    //   icon: Icons.person,
    //   hint: widget.name,
    //   onSaved: (value) {
    //     _name = value;
    //   },
    //   // textEditingController: nameController,
    // );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      initialValue: _initValues['email'],
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: widget.email,
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget messageTextFormField() {
    return CustomTextField(
      initialValue: _initValues['message'],
      keyboardType: TextInputType.text,
      icon: Icons.edit,
      hint: widget.message,
      onSaved: (value) {
        _message = value;
      },
    );
  }

  Widget button(GlobalKey<ScaffoldState> _scaffoldkey) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: _saveForm,
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // pref.setString("message", messageController.text.toString());
      // FirebaseAuth.instance.currentUser.uid;
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser.uid)
      //     .update({
      //   "name": _name,
      //   "email": _email,
      //   "message": _message,
      // }).catchError((e) {
      //   debugPrint(e);
      //   _scaffoldkey.currentState.showSnackBar(
      //       SnackBar(content: Text('Error Updating Profile Info')));
      // });
      // print(_name);
      // print(_message);
      // print(_email);

      // onPressed: () async {
      //   final c = collectionReference.doc(_user.uid);
      //   await c.get().then((DocumentSnapshot documentSnapshot) {
      //     print(documentSnapshot['email']);
      //   });
      // },
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
