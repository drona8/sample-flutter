import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AvatarStorageService {
  AvatarStorageService({@required this.uid});
  final String uid;

  Future<String> uploadAvatar({
    @required File file,
  }) async =>
      await upload(
        file: file,
        path: 'avatar/$uid' + '/avatar.png',
        contentType: 'image/png',
      );

  Future<String> upload({
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    print('uploading to: $path');
    final firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(path);
    final firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      contentType: contentType,
    );
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(file, metadata);
    final snapshot = await uploadTask.then((snap) => snap);
    if (snapshot.ref == null) {
      print('upload error code: ${snapshot.ref}');
      throw new Error();
    }
    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }

  Future<String> uploadFacility({
    @required File file,
    @required String key,
  }) async =>
      await uploadFacilityFile(
        file: file,
        path: 'facility/${key}/facility.png',
        contentType: 'image/png',
      );

  Future<String> uploadFacilityFile({
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    print('uploading to: $path');
    final firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(path);
    final firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      contentType: contentType,
    );
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(file, metadata);
    final snapshot = await uploadTask.then((snap) => snap);
    if (snapshot.ref == null) {
      print('upload error code: ${snapshot.ref}');
      throw new Error();
    }
    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
}
