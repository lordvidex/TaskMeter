import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:task_meter/core/constants.dart';
import 'package:task_meter/locale/locales.dart';
import 'package:task_meter/presentation/providers/authentication_provider.dart';
import 'package:task_meter/presentation/providers/settings_provider.dart';
import 'package:task_meter/presentation/providers/task_group_provider.dart';
import 'package:task_meter/presentation/screens/task_group_screen.dart';
import '../widgets/app_back_button.dart';
import '../widgets/authentication/social_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/authentication/email_signin_popup.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/auth';

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
  void didChangeDependencies() {
    // this user is not new anymore
    context.read<SettingsProvider>().isFirstTimeUser = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ModalProgressHUD(
      inAsyncCall: _authenticating,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBackButton(),
                    Padding(
                        padding: const EdgeInsets.only(top: 37, bottom: 50),
                        child: Text('Let\'s get started',
                            style: TextStyle(fontSize: 32))),
                    Image.asset(
                      'assets/images/auth_bg.png',
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
                    SocialButton(
                        buttonLabel: 'Sign in with Email',
                        onPressed: () => _showEmailPopup(context),
                        icon: Icon(Icons.email, size: 24)),
                    SocialButton(
                        buttonLabel:
                            appLocale.signIn + ' ${appLocale.withLabel} Google',
                        onPressed: () => _googleCallBack(signIn: true),
                        icon: SvgPicture.asset(
                          'assets/icons/google.svg',
                          height: 24,
                          width: 24,
                        )),
                    SocialButton(
                      buttonLabel:
                          appLocale.signIn + ' ${appLocale.withLabel} Apple',
                      onPressed: null,
                      icon: SvgPicture.asset(
                        'assets/icons/apple.svg',
                        height: 24,
                        width: 24,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SocialButton(
                        buttonLabel: 'Continue as Guest',
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                TaskGroupScreen.routeName, (_) => false),
                        icon: Icon(Icons.account_circle_outlined, size: 24)),
                    Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(
                            'By continuing, you confirm your agreement to our Terms of Service and privacy policy',
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 14))),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _showError(String result) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error occured!'),
              content: Text(result),
              actions: [
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(ctx).pop())
              ],
            ));
  }

  void _showEmailPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Constants.appDarkBlue
            : Constants.appSkyBlue,
        content: EmailSigninPopup(_emailCallBack),
      ),
    );
  }

  void _emailCallBack(String email, String password) async {
    toggleAuthentication(true);
    final _provider = context.read<AuthenticationProvider>();
    final result = await _provider.emailSignIn(email, password);

    if (result == null) {
      Navigator.of(context).pop();
    } else {
      _showError(result);
    }

    // make sure the list is updated
    await context.read<TaskGroupProvider>().loadTaskGroups();
    toggleAuthentication(false);
  }

  Future<void> _googleCallBack({bool signIn = false}) async {
    toggleAuthentication(true);
    final _provider = context.read<AuthenticationProvider>();
    String result = await _provider.googleSignIn();
    if (result == null) {
      Navigator.of(context).pop();
    } else {
      _showError(result);
    }
    await context.read<TaskGroupProvider>().loadTaskGroups();
    toggleAuthentication(false);
  }
}
