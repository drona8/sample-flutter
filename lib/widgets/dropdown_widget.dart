
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gumnaam/models/community.dart';
import 'package:gumnaam/style/style.dart';

class DropdownWidget extends StatefulWidget {
  final Community selectedMenu;
  final String hint;
  final List<Community> menuItem;
  final Function onChanged;
  final Function onValidate;
  final Function onSaved;

  DropdownWidget({
    this.selectedMenu,
    this.hint,
    this.menuItem,
    this.onChanged,
    this.onValidate,
    this.onSaved,
  });
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(top: 15.0),
      child: new DropdownButtonFormField<Community>(
        decoration: InputDecoration(
          labelText: widget.hint,
          labelStyle: hintStylesmBlackbPR(),
          fillColor: Colors.grey[200],
          filled: true,
          isDense: true,
          hintStyle:
              TextStyle(color: Colors.black45, fontWeight: FontWeight.w100),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 12.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color(0xFF707070).withOpacity(0.29),
              style: BorderStyle.none,
            ),
          ),
        ),
        style: hintStylesmBlackbPR(),
        onSaved: widget.onSaved,
        dropdownColor: Colors.white,
        validator: widget.onValidate,
        value: widget.selectedMenu != null ? widget.selectedMenu : null,
        onChanged: widget.onChanged,
        items: widget.menuItem.map(
          (Community label) {
            return new DropdownMenuItem<Community>(
              value: label,
              child: new Text(
                label.label,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
