import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/signup.dart';
// import 'package:provider/provider.dart';
//import 'package:safety_app/ui/screens/splashscreen.dart';
// import 'dashboard.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final userId = Provider.of<String>(context); //recieves String (uid) stream

    // if (userId != null)
    //   return Dashboard(); //returns home screen if logged in
    // else
    // return SplashScreen(); //returns signIn page if not logged in
    return SignUpScreen('7278419247');
  }
}
