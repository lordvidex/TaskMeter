import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants.dart';
import '../../core/failures.dart';
import '../../locale/locales.dart';
import '../providers/authentication_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/task_group_provider.dart';
import '../widgets/app_back_button.dart';
import '../widgets/authentication/email_signin_popup.dart';
import '../widgets/authentication/progress_overlay.dart';
import '../widgets/authentication/social_button.dart';
import 'task_group_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _authenticating = false;
  late AppLocalizations appLocale;

  void toggleAuthentication(bool value) {
    
      setState(() {
        _authenticating = value;
      });
    
  }

  @override
  void didChangeDependencies() {
    // this user is not new anymore
    context.read<SettingsProvider>().isFirstTimeUser = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    appLocale = AppLocalizations.of(context);
    return ProgressOverlay(
      loading: _authenticating,
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
                        child: Text(appLocale.getStarted,
                            style: TextStyle(fontSize: 32))),
                    Image.asset(
                      'assets/images/auth_bg.png',
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
                    SocialButton(
                        buttonLabel: appLocale.continueWith('Email'),
                        onPressed: () => _showEmailPopup(context),
                        icon: Icon(Icons.email, size: 24)),
                    SocialButton(
                        buttonLabel: appLocale.continueWith('Google'),
                        onPressed: () => _googleCallBack(signIn: true),
                        icon: SvgPicture.asset(
                          'assets/icons/google.svg',
                          height: 24,
                          width: 24,
                        )),
                    if (Platform.isIOS)
                      SocialButton(
                        buttonLabel: appLocale.continueWith('Apple'),
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
                        buttonLabel: appLocale.continueAsGuest,
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                TaskGroupScreen.routeName, (_) => false),
                        icon: Icon(Icons.account_circle_outlined, size: 24)),
                    Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(appLocale.termsAndServices,
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
              title: Text(appLocale.errorOccured),
              content: Text(result),
              actions: [
                TextButton(
                    child: Text(appLocale.cancel),
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

    toggleAuthentication(false);

    if (result == null) {
      // make sure the list is updated
      await context.read<TaskGroupProvider>().loadTaskGroups();
      // move to task screen
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TaskGroupScreen.routeName, (_) => false);
    } else {
      if (result is UserDoesNotExistFailure) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(appLocale.newAccount),
                  content: Text(
                    appLocale.newAccountAgreement,
                  ),
                  actions: [
                    TextButton(
                      child: Text(appLocale.continueLabel),
                      onPressed: () async {
                        final result =
                            await _provider.emailSignUp(email, password);
                        if (result == null) {
                          // make sure the list is updated
                          await context
                              .read<TaskGroupProvider>()
                              .loadTaskGroups();
                          // move to task screen
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              TaskGroupScreen.routeName, (_) => false);
                        } else
                          _showError(result.toString());
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text(appLocale.cancel))
                  ],
                ));
      } else {
        _showError(result.toString());
      }
    }
  }

  Future<void> _googleCallBack({bool signIn = false}) async {
    toggleAuthentication(true);

    final _provider = context.read<AuthenticationProvider>();
    final result = await _provider.googleSignIn();

    toggleAuthentication(false);

    if (result == null) {
      // make sure the list is updated
      await context.read<TaskGroupProvider>().loadTaskGroups();
      // move to task screen
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TaskGroupScreen.routeName, (_) => false);
    } else {
      _showError(result.toString());
    }
  }
}
