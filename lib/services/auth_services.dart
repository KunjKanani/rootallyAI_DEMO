import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<String> signUpUsingFirebase(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return await signInUsingFirebase(email: email, password: password);
      }
    }
    return "success";
  }

  static Future<String> signInUsingFirebase(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return "ERROR" + e.toString();
    }
  }
}
