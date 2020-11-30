import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtility {
  static Widget getFittedBox(BuildContext context, int index) {
    //int day = DateTime.now().day + index;
    return FittedBox(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        color: Colors.grey.withOpacity(0.1),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              DateTime.now().add(Duration(days: index)).day.toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
            Text(
              DateFormat('EE')
                  .format(DateTime.now().add(Duration(days: index))),
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }
}
