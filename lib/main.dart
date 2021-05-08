import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/providers/contact_provider.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/signin.dart';
import 'ui/screens/signup.dart';
import 'ui/screens/splashscreen.dart';
import 'package:safety_app/ui/screens/signin.dart';
import 'package:safety_app/ui/screens/signup.dart';
import 'package:safety_app/ui/screens/splashscreen.dart';
//import './ui/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (ctx) => ContactProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login",
        theme: ThemeData(
          primaryColor: Colors.orange[200],
          //accentColor:
        ),

        initialRoute: SplashScreen.routeName,
        //initialRoute: Dashboard.routeName,
        routes: <String, WidgetBuilder>{
          SplashScreen.routeName: (ctx) => SplashScreen(),
          SignInPage.routeName: (ctx) => SignInPage(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          //RecoveryPage.routeName: (ctx) => RecoveryPage(),
          Dashboard.routeName: (ctx) => Dashboard(),
        },
      ),
    );
  }
}
