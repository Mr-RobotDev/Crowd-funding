import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  Future<User?> anonymousSignIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      return credential.user;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException {
      return null;
    }
  }

  String getCurrentUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      bool ifEmailExist = await checkIfEmailInUse(email);
      if (ifEmailExist) {
        return null;
      } else {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      }
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return true;
    }
  }

  Future<void> logout() async {
    return FirebaseAuth.instance.signOut();
  }
}
