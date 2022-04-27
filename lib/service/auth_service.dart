import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> userSetup(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String? uid = _auth.currentUser?.uid.toString();
    users.add({'email': email, 'uid': uid});
    return;
  }

  Future<String?> submitAuthForm({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        userSetup(email);
        return 'New user registered!';
      } else if (e.code == 'wrong-password') {
        return 'The password is invalid.';
      } else if (e.code == 'network-request-failed') {
        return 'A network error has occurred';
      } else {
        return 'Error: logging in failed. Please, try again later';
      }
    }
    return null;
  }
}
