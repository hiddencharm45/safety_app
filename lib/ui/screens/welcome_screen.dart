import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/otp_screen.dart';
//import 'package:safety_app/ui/test.dart';
import '../widgets/custom_shape.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/textformfield.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              SizedBox(height: _height / 10),
              form(),
              SizedBox(height: _height / 25),
              //-----------------Removed Redundant code(Button Widget)-----------------

              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            phoneTextFormField(),
            SizedBox(height: _height / 40.0),
          ],
        ),
      ),
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.phone,
      textEditingController: phoneController,
      icon: Icons.phone_android,
      hint: "Enter phone number",
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
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
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
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
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        // print(phoneController.text);
        //Phone number validation Added Here--------------

        String pattern = r'(^[6789]\d{9}$)';
        RegExp regExp = new RegExp(pattern);
        if (phoneController.text.length == 0) {
          return _scaffoldkey.currentState
              .showSnackBar(SnackBar(content: Text('Field Empty')));
        } else if (phoneController.text.length != 10) {
          return _scaffoldkey.currentState
              .showSnackBar(SnackBar(content: Text('Must be 10 digits')));
        } else if (!regExp.hasMatch(phoneController.text)) {
          return _scaffoldkey.currentState
              .showSnackBar(SnackBar(content: Text('Invalid Phone Number')));
        }

        return Navigator.of(context).pushReplacementNamed(OtpScreen.routeName,
            arguments: {'phone': phoneController.text.toString()});
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Verify Number',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome Back!",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: _large ? 50 : (_medium ? 40 : 30),
            ),
          ),
        ],
      ),
    );
  }
}

//   Widget signInTextRow() {
//     return Container(
//       margin: EdgeInsets.only(left: _width / 15.0),
//       child: Row(
//         children: <Widget>[
//           Text(
//             "Sign in to your account",
//             style: TextStyle(
//               fontWeight: FontWeight.w200,
//               fontSize: _large ? 20 : (_medium ? 17.5 : 15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Widget emailTextFormField() {
//     return CustomTextField(
//       keyboardType: TextInputType.emailAddress,
//       textEditingController: emailController,
//       icon: Icons.email,
//       hint: "Email ID",
//     );
//   }

//   Widget passwordTextFormField() {
//     return CustomTextField(
//       keyboardType: TextInputType.emailAddress,
//       textEditingController: passwordController,
//       icon: Icons.lock,
//       obscureText: true,
//       hint: "Password",
//     );
//   }

//   Widget forgetPassTextRow() {
//     return Container(
//       margin: EdgeInsets.only(top: _height / 40.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "Forgot your password?",
//             style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: _large ? 14 : (_medium ? 12 : 10)),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           GestureDetector(
//             onTap: () {
//               // Navigator.of(context).pushNamed(
//               // RecoveryPage.routeName); //here I/ve manipulated the code
//               print("Routing");
//             },
//             child: Text(
//               "Recover",
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.orange[200]),
//             ),
//           )
//         ],
//       ),
//     );
//   }

// Widget signUpTextRow() {
//     return Container(
//       margin: EdgeInsets.only(top: _height / 120.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "Don't have an account?",
//             style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: _large ? 14 : (_medium ? 12 : 10)),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.of(context).pushNamed(SignUpScreen.routeName);
//               print("Routing to Sign up screen");
//             },
//             child: Text(
//               "Sign up",
//               style: TextStyle(
//                   fontWeight: FontWeight.w800,
//                   color: Colors.orange[200],
//                   fontSize: _large ? 19 : (_medium ? 17 : 15)),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
