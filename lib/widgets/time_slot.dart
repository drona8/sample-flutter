import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/style/color.dart';

class TimeSlot extends StatefulWidget {
  final String slot;
  final Color color;
  final Color textColor;
  TimeSlot({
    this.slot,
    this.color,
    this.textColor,
  });
  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColor.BLACK, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      child: Text(
        widget.slot,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
