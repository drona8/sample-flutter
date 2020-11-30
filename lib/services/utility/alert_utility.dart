import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/booking.dart';
import 'package:gumnaam/services/db/booking_service.dart';

class AlertUtility {
  static Future<void> showAlertDialog(
      BuildContext context, Widget content, Booking booking,BookingService _bookingService) async {
    Widget cancelButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("YES"),
      onPressed: () async {
        await _bookingService.addBooking(booking);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Booking",
        style: Theme.of(context).textTheme.headline3,
      ),
      content: content,
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
