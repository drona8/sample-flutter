import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/community.dart';

class CommunityService {
  final String uid;

  CommunityService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> addCommunity(Community community) async {
    return await _firestore.collection('communities').add(community.toJson());
  }

  Future<void> removeCommunity(String id) async {
    await _firestore.collection('communities').doc(id).delete();
  }

  Future<void> updateCommunity(Community community) async {
    await _firestore.collection('communities').doc(community.id).update(community.toJson());
  }

  Stream<QuerySnapshot> getAllCommunities() {
    return _firestore.collection('communities').get().asStream();
  }
}
