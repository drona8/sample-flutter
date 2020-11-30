import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  LabelWidget({this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
