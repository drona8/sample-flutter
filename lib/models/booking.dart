class Booking {
  String id;
  String bookey;
  String facilityId;
  String bookingTimeSlot;
  DateTime bookingDate;

  Booking({
    this.id,
    this.bookey,
    this.facilityId,
    this.bookingTimeSlot,
    this.bookingDate,
  });

  factory Booking.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Booking(
      bookey: data['bookey'],
      facilityId: data['facilityId'],
      bookingTimeSlot: data['bookingTimeSlot'],
      bookingDate: data['bookingDate'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonUser = new Map<String, dynamic>();
    jsonUser['bookey'] = this.bookey;
    jsonUser['facilityId'] = this.facilityId;
    jsonUser['bookingTimeSlot'] = this.bookingTimeSlot;
    jsonUser['bookingDate'] = this.bookingDate;
    return jsonUser;
  }
}