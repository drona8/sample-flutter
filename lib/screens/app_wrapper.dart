import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'private/home_wrapper.dart';
import 'package:provider/provider.dart';

import 'public/welcome_screen.dart';
import '../models/user.dart';
import '../services/db/user_service.dart';

class AppWrapper extends StatelessWidget {
  AppWrapper({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<auth.User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot == null) {
      return WelcomeScreen();
    } else if (userSnapshot.connectionState == ConnectionState.active &&
        userSnapshot.data == null) {
      return WelcomeScreen();
    } else if (userSnapshot.connectionState == ConnectionState.active) {
      final userService =
          Provider.of<UserService>(context, listen: false);
      return StreamBuilder<User>(
        stream: userService.appHero,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            user.uid = userSnapshot.data.uid;
            return HomeWrapper(
              user: user,
            );
          }else{
            return WelcomeScreen();
          }
        },
      );
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}