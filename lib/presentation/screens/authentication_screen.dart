import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_meter/locale/locales.dart';

// class AuthenticationScreen extends StatefulWidget {
//   @override
//   _AuthenticationScreenState createState() => _AuthenticationScreenState();
// }

// class _AuthenticationScreenState extends State<AuthenticationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: AuthenticationCard()));
//   }
// }

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: SingleChildScrollView(
      child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            SizedBox(height: 20),
            Placeholder(
              fallbackHeight: 60,
              fallbackWidth: 60,
            ),
            SizedBox(height: 10),
            SignInOrSignUp(),
          ])),
    ));
  }
}

class SignInOrSignUp extends StatefulWidget {
  @override
  _SignInOrSignUpState createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _emailController;
  int _index = 0;
  GlobalKey _formKey;
  bool _isEmailMode = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() => _index = _tabController.index);
      });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: Column(children: [
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
            ? TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: appLocale.enterEmail),
              )
            : GestureDetector(
                onTap: _togglePasswordMode,
                child: Text(_emailController.text,
                    style: TextStyle(color: Colors.blue))),
        SizedBox(height: 20),
        SocialButton(
          buttonLabel: _isEmailMode
              ? appLocale.next
              : _index == 0
                  ? appLocale.signIn
                  : appLocale.signup,
          onPressed: _togglePasswordMode,
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
            onPressed: () {},
            buttonColor: Colors.white,
            textColor: Colors.black,
            icon: SvgPicture.asset(
              'assets/icons/google.svg',
              height: 24,
              width: 24,
            )),
        SizedBox(height: 10),
        SocialButton(
          buttonLabel: (_index == 0 ? appLocale.signIn : appLocale.signup) +
              ' with Apple',
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/apple.svg',
            color: Colors.white,
            height: 24,
            width: 24,
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
      ]),
    );
  }

  void _togglePasswordMode() {
    setState(() {
      _isEmailMode = !_isEmailMode;
    });
  }
}

class SocialButton extends StatelessWidget {
  final Function() onPressed;
  final Color buttonColor;
  final String buttonLabel;
  final Widget icon;
  final Color textColor;
  const SocialButton({
    this.icon = const Icon(Icons.favorite),
    @required this.buttonLabel,
    @required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton.icon(
            label: Text(buttonLabel,
                style: TextStyle(color: textColor, fontFamily: 'Roboto')),
            icon: icon,
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
            )));
  }
}
