import 'package:flutter/material.dart';
import 'package:task_meter/core/constants.dart';
import 'package:task_meter/locale/locales.dart';
import 'package:task_meter/presentation/screens/authentication_screen.dart';
import 'package:task_meter/presentation/widgets/task_timer/action_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/yoga.png', fit: BoxFit.fitWidth),
              Padding(
                padding: const EdgeInsets.only(top: 75, left: 51, right: 51),
                child: Text(
                  'An app that helps you stay focused',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 34,
              child: Container(
                width: 229,
                child: ActionButton(
                  resizable: false,
                  text: appLocale.next,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AuthenticationScreen.routeName),
                  fillColor: Constants.appBlue,
                ),
              ))
        ],
      ),
    ));
  }
}
