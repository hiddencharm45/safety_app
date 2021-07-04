import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/screens/chat_screen.dart';
import 'package:safety_app/ui/screens/otp_screen.dart';
import 'package:safety_app/ui/services/auth.dart';
import 'ui/screens/dashboard.dart';
import 'package:safety_app/ui/screens/welcome_screen.dart';
import 'package:safety_app/ui/screens/signup.dart';
import 'package:safety_app/ui/screens/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        //listens to the changes in contact list
        Provider<AuthService>(
            builder: (ctx) => AuthService(FirebaseAuth.instance)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login",
        theme: ThemeData(primaryColor: Colors.orange[200]),

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (userSnapshot.hasData) {
              //that is if we found the token/user_session
              return Dashboard();
            }
            return SplashScreen();
          },
        ),

        //initialRoute: SplashScreen.routeName,
        //initialRoute: Dashboard.routeName,

        routes: <String, WidgetBuilder>{
          SplashScreen.routeName: (ctx) => SplashScreen(),
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen("", ""),
          OtpScreen.routeName: (ctx) => OtpScreen(),
          Dashboard.routeName: (ctx) => Dashboard(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
        },
      ),
    );
  }
}
