import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/dashboard.dart';
import 'package:safety_app/ui/widgets/user_image.dart';
import '../widgets/custom_shape.dart';
import '../widgets/customappbar.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/textformfield.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  final String phone;
  final String uid;

  SignUpScreen(this.phone, this.uid);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  File _image;

  void _pickedImage(File image) {
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        key: _scaffoldkey,
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(_scaffoldkey),
                //infoTextRow(),
                //socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
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
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          // child: GestureDetector(
          //     onTap: () => UserImagePicker(_pickedImage),
          //     child: Icon(
          //       Icons.add_a_photo,
          //       size: _large ? 40 : (_medium ? 33 : 31),
          //       color: Colors.orange[200],
          //     )),
          child: UserImagePicker(_pickedImage),
        ),
        //  Positioned(
        //    top: _height/8,
        //    left: _width/1.75,
        //    child: Container(
        //      alignment: Alignment.center,
        //      height: _height/23,
        //      padding: EdgeInsets.all(5),
        //      decoration: BoxDecoration(
        //        shape: BoxShape.circle,
        //        color:  Colors.orange[100],
        //      ),
        //      child: GestureDetector(
        //          onTap: (){
        //            print('Adding photo');
        //          },
        //          child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
        //    ),
        //  ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _width / 12.0),
      child: Form(
        child: Column(
          children: <Widget>[
            phoneTextFormField(),
            SizedBox(height: _height / 20.0),
            nameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            //SizedBox(height: _height / 60.0),
          ],
        ),
      ),
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.phone_android,
      bgColor: Colors.orange[100],
      hint: "+91 " + widget.phone,
      isReadOnly: true,
    );
  }

  Widget nameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Enter Your Full Name",
      textEditingController: nameController,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Enter Your Email ID",
      textEditingController: emailController,
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button(GlobalKey<ScaffoldState> _scaffoldkey) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        final ref = FirebaseStorage.instance.ref().child(widget.uid + '.jpg');
        await ref.putFile(_image).onComplete;
        final url = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .set({
              "name": nameController.text.toString(),
              "email": emailController.text.toString().trim(),
              "phone": widget.phone,
              "image_url": url,
              "message": "I'm in DANGER, Please help!!"
            })
            //collectionReference
            // .add(data)
            .then((value) =>
                Navigator.of(context).pushReplacementNamed(Dashboard.routeName))
            .catchError(() {
              print("Error Signing Up");
              _scaffoldkey.currentState
                  .showSnackBar(SnackBar(content: Text('Error Signing Up')));
            });
        print("Routing to your account");
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
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }
}
