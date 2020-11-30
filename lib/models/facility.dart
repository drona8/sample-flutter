import 'dart:io';

import 'model.dart';

class Facility extends Model {
  String id;
  String title;
  String shortDescription;
  String longDescription;
  DateTime creationTime;
  String imageURL;
  String communityId;
  bool isEnabled;
  File file;

  Facility({
    this.id,
    this.title,
    this.shortDescription,
    this.longDescription,
    this.creationTime,
    this.imageURL,
    this.communityId,
    this.isEnabled,
    this.file,
  });

  factory Facility.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Facility(
      title: data['title'],
      shortDescription: data['shortDescription'],
      longDescription: data['longDescription'],
      creationTime: data['creationTime'].toDate(),
      imageURL: data['imageURL'],
      isEnabled: data['isEnabled'],
      communityId: data['communityId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonUser = new Map<String, dynamic>();
    jsonUser['title'] = this.title;
    jsonUser['shortDescription'] = this.shortDescription;
    jsonUser['longDescription'] = this.longDescription;
    jsonUser['creationTime'] = this.creationTime;
    jsonUser['imageURL'] = this.imageURL;
    jsonUser['communityId'] = this.communityId;
    jsonUser['isEnabled'] = this.isEnabled;    
    return jsonUser;
  }
}
