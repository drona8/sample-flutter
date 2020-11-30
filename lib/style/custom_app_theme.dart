import 'package:flutter/material.dart';

import 'style.dart';

import 'color.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.LIGHT_BACKGROUND_COLOR,
    primarySwatch: AppColor.BLUE,
    accentColor: AppColor.blue,
    appBarTheme: AppBarTheme(
      color: AppColor.LIGHT_BACKGROUND_COLOR,
      elevation: 0,
    ),
    bottomAppBarTheme:
        BottomAppBarTheme(color: Colors.white10, elevation: 10.0),
    fontFamily: "Poppins",
    textTheme: TextTheme(
      headline3: hintStylesmBlackbPR(),
      headline4: hintStylewhitetextPSB(),
      headline5: hintStylesmallbluePR(),
      headline6: hintStyleFacilityText(),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
