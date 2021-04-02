import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/presentation/providers/task_group_provider.dart';

import '../../../core/utils/string_utils.dart';
import '../../../locale/locales.dart';
import '../../providers/authentication_provider.dart';
import 'social_button.dart';

class SignInOrSignUp extends StatefulWidget {
  final Function authFunction;
  SignInOrSignUp({@required this.authFunction});
  @override
  _SignInOrSignUpState createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _index = 0;
  bool _isEmailMode = true;

  AuthenticationProvider _provider;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  GlobalKey<FormState> _emailFormKey;
  GlobalKey<FormState> _passwordFormKey;

  @override
  void initState() {
    _provider = context.read<AuthenticationProvider>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFormKey = GlobalKey();
    _passwordFormKey = GlobalKey();

    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() => _index = _tabController.index);
      });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Column(children: [
      TabBar(
        tabs: [
          Tab(
            text: appLocale.signIn,
          ),
          Tab(
            text: appLocale.signup,
          ),
        ],
        controller: _tabController,
      ),
      //Text(_index == 0 ? appLocale.signIn : appLocale.signup),
      SizedBox(height: 15),
      _isEmailMode
          ? Form(
              key: _emailFormKey,
              child: TextFormField(
                controller: _emailController,
                validator: (string) => StringUtils.formatMail(string.trim()),
                decoration: InputDecoration(hintText: appLocale.enterEmail),
              ),
            )
          : Column(children: [
              GestureDetector(
                  onTap: _toggleEmailPasswordMode,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, size: 24, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(_emailController.text,
                          style: TextStyle(color: Colors.blue)),
                    ],
                  )),
              SizedBox(height: 15),
              Form(
                key: _passwordFormKey,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (string) => StringUtils.formatPassword(string),
                  decoration:
                      InputDecoration(hintText: appLocale.enterPassword),
                ),
              )
            ]),
      SizedBox(height: 20),
      SocialButton(
        buttonLabel: _isEmailMode
            ? appLocale.next
            : _index == 0
                ? appLocale.signIn
                : appLocale.signup,
        onPressed: () => _isEmailMode
            ? _toggleEmailPasswordMode()
            : _emailCallBack(
                signIn: _index == 0,
                email: _emailController.text,
                password: _passwordController.text,
              ),
        buttonColor: Colors.blue,
        icon: Container(),
      ),
      Divider(
        height: 40,
        thickness: 3,
      ),
      SocialButton(
          buttonLabel: (_index == 0 ? appLocale.signIn : appLocale.signup) +
              ' with Google',
          onPressed: () => _googleCallBack(signIn: _index == 0),
          buttonColor: Colors.white,
          textColor: Colors.black,
          icon: SvgPicture.asset(
            'assets/icons/google.svg',
            height: 24,
            width: 24,
          )),
      SizedBox(height: 10),
      SocialButton(
        buttonLabel:
            (_index == 0 ? appLocale.signIn : appLocale.signup) + ' with Apple',
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/apple.svg',
          color: Colors.white,
          height: 22,
          width: 22,
        ),
        buttonColor: Colors.black,
      ),
      Divider(
        height: 10,
        thickness: 2,
      ),
      SocialButton(
        buttonLabel: 'Close',
        onPressed: () => Navigator.of(context).pop(),
        buttonColor: Colors.red,
        icon: Container(),
      )
    ]);
  }

  /// Switches between the email and password mode
  /// if(email string is valid):
  ///    email -> password
  /// password -> email
  void _toggleEmailPasswordMode() {
    if (_isEmailMode && !_emailFormKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isEmailMode = !_isEmailMode;
    });
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

  void _emailCallBack({bool signIn, String email, String password}) async {
    widget.authFunction(true);
    if (signIn) {
      final result = await _provider.emailSignIn(email, password);
      if (result == null) {
        Navigator.of(context).pop();
        print('successfully logged in');
      } else {
        _showError(result);
      }
    } else {
      // sign up
      final result = await _provider.emailSignUp(email, password);
      if (result == null) {
        Navigator.of(context).pop();
        print('successfully signed up');
      } else {
        _showError(result);
      }
    }

    // make sure the list is updated
    await context.read<TaskGroupProvider>().loadTaskGroups();
    widget.authFunction(false);
  }

  Future<void> _googleCallBack({bool signIn}) async {
    widget.authFunction(true);
    String result = signIn
        ? await _provider.googleSignIn()
        : await _provider.googleSignUp();
    if (result == null) {
      Navigator.of(context).pop();
      print('successfully signed ${signIn ? 'in' : 'up'} with google');
    } else {
      _showError(result);
    }
    await context.read<TaskGroupProvider>().loadTaskGroups();
    widget.authFunction(false);
  }
}
