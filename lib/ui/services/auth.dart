import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInEmail() async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: null, password: null);
      //_auth.
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
