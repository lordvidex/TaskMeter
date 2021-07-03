import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../widgets/authentication/signin_or_signup.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _authenticating = false;
  void toggleAuthentication(bool value) {
    if (_authenticating != null) {
      setState(() {
        _authenticating = value;
      });
    }
  }

  @override
  void dispose() {
    _authenticating = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _authenticating,
      child: Card(
          child: SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/task_app.png',
                height: 60,
              ),
              SizedBox(height: 10),
              SignInOrSignUp(authFunction: toggleAuthentication),
            ])),
      )),
    );
  }
}
