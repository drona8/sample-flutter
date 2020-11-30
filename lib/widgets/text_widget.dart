import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gumnaam/services/utility/form_utility.dart';

class TextWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String suffixIconPath;
  final bool obscureText;
  final int maxLine;
  TextWidget({
    this.controller,
    this.hintText,
    this.suffixIconPath,
    this.obscureText,
    this.maxLine
  });
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool _isVisible;
  @override
  void initState() {
    _isVisible = widget.obscureText;
    super.initState();
  }

  IconData _getIconData() {
    String label = widget.hintText;
    switch (label) {
      case 'First Name':
        return Icons.person;
        break;
      case 'Last Name':
        return Icons.person;
        break;
      case 'Email':
        return Icons.email;
        break;
      case 'Community Title':
        return Icons.title;
        break;
      case 'Short Description':
        return Icons.description;
        break;
      case 'Password':
        if (_isVisible) {
          return Icons.remove_red_eye;
        } else if (!_isVisible) {
          return Icons.remove_red_eye_outlined;
        }

        break;
      default:
        return Icons.local_grocery_store;
    }
  }

  _getObscurePassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(top: 15.0),
      child: TextFormField(
        controller: widget.controller,
        validator: (String value) {
          return FormUtility.fieldValidator(value, widget.hintText);
        },
        maxLines: widget.maxLine!=null?widget.maxLine:1,
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.headline3,
          alignLabelWithHint: true,
          fillColor: Colors.grey[200],
          filled: true,
          isDense: true,
          //suffixIcon: Image.asset(widget.suffixIconPath),
          suffixIcon: GestureDetector(
            child: Icon(
              _getIconData(),
              color: Colors.grey[500],
            ),
            onTap: () {
              if (widget.hintText.toLowerCase().contains('password')) {
                _getObscurePassword();
              }
            },
          ),

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
        style: Theme.of(context).textTheme.headline3,
        obscureText: _isVisible,
      ),
    );
  }
}
