import 'package:blocauth/models/failure_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthRepo {
  Future<bool> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);

      throw Failure(code: e.code, msg: e.message);
    } on PlatformException catch (e) {
      print(e.message);
      throw Failure(code: e.code, msg: e.message);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Failure(code: e.code, msg: e.message);
    } on PlatformException catch (e) {
      throw Failure(code: e.code, msg: e.message);
    }
  }
}
