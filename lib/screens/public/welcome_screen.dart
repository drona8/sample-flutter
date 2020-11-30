import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/screens/public/login_screen.dart';
import 'package:gumnaam/screens/public/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isCurrentScreenIsLogin;

  @override
  void initState() {
    _isCurrentScreenIsLogin = false;
    super.initState();
  }

  Widget _getFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        child: Wrap(
          children: [
            Text(_isCurrentScreenIsLogin
                ? 'Already have account? '
                : 'Do not have account? '),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isCurrentScreenIsLogin = !_isCurrentScreenIsLogin;
                });
              },
              child: Text(
                _isCurrentScreenIsLogin ? 'Login' : 'SignUp',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: _isCurrentScreenIsLogin ? SignupScreen() : LoginScreen(),
              ),
            ),
            _getFooter(context),
          ],
        ),
      ),
    );
  }
}
