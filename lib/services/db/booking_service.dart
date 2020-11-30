import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumnaam/models/booking.dart';

class BookingService {
  final String uid;

  BookingService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> addBooking(Booking booking) async {
    booking.bookey = uid;
    return await _firestore.collection('bookings').add(booking.toJson());
  }

  Future<void> removeBooking(String id) async {
    await _firestore.collection('bookings').doc(id).delete();
  }

  Future<void> updateBooking(Booking booking) async {
    await _firestore
        .collection('bookings')
        .doc(booking.id)
        .update(booking.toJson());
  }

  Stream<QuerySnapshot> getAllBookings() {
    return _firestore
        .collection('bookings')
        .where(
          'bookingDate',
          isGreaterThanOrEqualTo: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        )
        .orderBy('bookingDate', descending: true)
        .orderBy(
          'bookingTimeSlot',
          descending: true,
        )
        .get()
        .asStream();
  }
}
