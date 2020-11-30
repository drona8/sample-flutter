import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user.dart';

class UserService {
  final String uid;

  UserService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User> get appHero {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) => User.fromMap(snap.data()));
  }

  Future<bool> doesUserExists({String email}) async {
    var _result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email.trim())
        .limit(1)
        .get();
    if (_result.docs.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> addUser({@required User user}) async {
    try {
      await _firestore.collection('users').doc(uid).set(user.toJson());
      return true;
    } catch (e) {
      print('Exception while adding user : '+e.toString());
      return false;
    }
  }
}
