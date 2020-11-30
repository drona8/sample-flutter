import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class AvatarService {
  AvatarService({@required this.uid}) : assert(uid != null);
  final String uid;
  Future<void> setAvatarReference(String avatarReference) async {
    final reference = FirebaseFirestore.instance.collection('users').doc(uid);

    await reference.update({
      "imageUrl": avatarReference,
    });
  }

  // Reads the current avatar download url
  Stream<String> avatarReferenceStream() {
    final path = 'avatar/$uid';
    final reference = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) {
      if (snapshot.data == null) {
        return null;
      }
      User _ur = User.fromMap(snapshot.data());
      _ur.uid = snapshot.id;
      final profilePics = _ur.imageUrl;

      if (profilePics == null) {
        return null;
      }
      return profilePics;
    });
  }
}
