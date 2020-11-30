import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'color.dart';

TextStyle hintStylesmBlackbPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
    color: AppColor.textColor.withOpacity(0.51),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylewhitetextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: AppColor.whiteText,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStylesmallbluePR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: AppColor.blue,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleAppBarTitle() {
  return TextStyle(
    fontSize: 18.0,
    fontFamily: "PoppinsMedium",
    fontStyle: FontStyle.normal,
    color: AppColor.blacktext,
    fontWeight: FontWeight.w400,
  );
}

TextStyle hintStyleListTileText() {
  return TextStyle(
    fontSize: 14.0,
    fontFamily: "PoppinsRegular",
    fontStyle: FontStyle.normal,
    color: AppColor.BLACK,
    //letterSpacing: 0.6,
    fontWeight: FontWeight.w400,
  );
}

TextStyle hintStyleFacilityText() {
  return TextStyle(
    fontSize: 16.0,
    fontFamily: "PoppinsMedium",
    fontStyle: FontStyle.normal,
    color: Colors.black,
    letterSpacing: 0.6,
    fontWeight: FontWeight.w400,
  );
}
