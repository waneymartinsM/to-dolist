import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool checkCurrentUser() {
    User? user = _auth.currentUser;
    return user != null ? true : false;
  }
}