import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumnaam/models/community.dart';
import '../../models/facility.dart';

class FacilityService {
  final String uid;

  FacilityService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> addFacility(Facility facility) async {
    return await _firestore.collection('facilities').add(facility.toJson());
  }

  Future<void> removeFacility(String id) async {
    await _firestore.collection('facilities').doc(id).delete();
  }

  Future<void> disabledFacility(String id, bool flag) async {
    print('sdbf '+id+flag.toString());
    await _firestore
        .collection('facilities')
        .doc(id)
        .update({'isEnabled': flag});
  }

  Future<void> updateFacility(Facility facility) async {
    await _firestore
        .collection('facilities')
        .doc(facility.id)
        .update(facility.toJson());
  }

  Stream<QuerySnapshot> getAllFacility(Community community, bool flag) {
    return _firestore
        .collection('facilities')
        .where('communityId', isEqualTo: community.id)
        .where('isEnabled', isEqualTo: flag)
        .snapshots();
  }
}
