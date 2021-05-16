import 'package:firebase_auth/firebase_auth.dart';
import 'package:safety_app/ui/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser _firebaseUserToCustomUser(UserCredential userCred) {
    return (userCred != null) ? CustomUser(uid: userCred.user.uid) : null;
    //copying relevant UserCredential data into custom CustomUser type
  }

  Future signInEmail() async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: null, password: null);
      return _firebaseUserToCustomUser(result);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
