import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../models/user.dart';
import '../../services/db/user_service.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Stream<auth.User> get user {
    return _auth.authStateChanges().map((event) {
      return event;
    });
  }

  Future<String> registerUser({
    @required User user,
  }) async {
    try {
      UserService _userService = UserService(uid: null);
      final bool _isuserExits =
          await _userService.doesUserExists(email: user.email);

      if (!_isuserExits) {
        final auth.UserCredential _userCred =
            await _auth.createUserWithEmailAndPassword(
          email: user.email.trim(),
          password: user.password.trim(),
        );
        final auth.User _user = _userCred.user;
        if (_user.uid != null) {
          _userService = UserService(uid: _user.uid);
          await _userService.addUser(
            user: user,
          );
          return 'Success';
          //await _user.sendEmailVerification();
        }
        return 'Fail';
      } else {
        return 'Duplicate';
      }
    } catch (e) {
      String err = e.toString().substring(e.toString().lastIndexOf(']') + 1);
      return err;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<String> loginWithEmailAndPassword({
    User user,
  }) async {
    try {
      final auth.UserCredential _userCred =
          await _auth.signInWithEmailAndPassword(
              email: user.email, password: user.password);
      auth.User _user = _userCred.user;

      if (_user.uid != null) {
        return 'Success';
      }
      return "FAILED:";
    } on PlatformException catch (err) {
      print('Failed with error code: ${err.code}');
      switch (err.code) {
        case 'user-not-found':
          return 'FAILED: No user found.';
          break;
        default:
        return 'FAILED: ${err.message}';
      }
    } on auth.FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      switch (e.code) {
        case 'user-not-found':
          return 'FAILED: No user found.';
          break;
        default:
        return 'FAILED: ${e.message}';
      }
    } catch (e) {
      return 'FAILED: ' + e.trim();
    }
  }
}
