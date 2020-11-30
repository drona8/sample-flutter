import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/user.dart';
import '../../services/utility/form_utility.dart';
import '../../widgets/app_button.dart';
import '../../widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController, _passwordController;
  bool _isLoading = false;
  bool _isError = false;
  String _errorMsg;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                hintText: 'Email',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _emailController,
              ),
              TextWidget(
                hintText: 'Password',
                suffixIconPath: 'assets/icons/password.png',
                obscureText: true,
                controller: _passwordController,
              ),
              _isError
                  ? Text(
                      _errorMsg,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : SizedBox.shrink(),
              AppButton(
                label: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                onPressed: () async {

                  User user = User(
                    email: _emailController.text,
                    password: _passwordController.text,
                    type: 'user',
                  );
                  setState(() {
                    _isLoading = true;
                    _isError = false;
                      _errorMsg = null;
                  });
                  final String res =
                      await FormUtility.proceed(_loginFormKey, user, 'Login');
                  if (res.contains('FAILED')) {
                    setState(() {
                      _isError = true;
                      _errorMsg = res;
                    });
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
