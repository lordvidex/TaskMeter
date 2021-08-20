import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/utils/string_utils.dart';
import '../../../locale/locales.dart';
import '../../providers/authentication_provider.dart';
import '../create_task_group/custom_text_form_field.dart';
import '../task_timer/action_button.dart';

class EmailSigninPopup extends StatefulWidget {
  final Function(String, String) emailCallBack;
  EmailSigninPopup(this.emailCallBack);
  @override
  _EmailSigninPopupState createState() => _EmailSigninPopupState();
}

class _EmailSigninPopupState extends State<EmailSigninPopup>
    with SingleTickerProviderStateMixin {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  // number of times the continue button has been clicked
  int _tries;

  bool _loading;

  // whether to show just the email textfield or both
  bool _recoveryMode;

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _tries = 0;
    _loading = false;
    _recoveryMode = false;
    _formKey = GlobalKey();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
              padding: const EdgeInsets.only(
                bottom: 48,
              ),
              child: Image.asset('assets/images/task_app.png',
                  fit: BoxFit.fitWidth)),
          if (_recoveryMode)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(appLocale.enterRecoveryMail)),
            ),
          CustomTextFormField(
            controller: _emailController,
            validator: (string) => StringUtils.formatMail(string.trim()),
            hintText: appLocale.enterEmail,
          ),
          SizedBox(
            height: 10,
          ),
          if (!_recoveryMode)
            CustomTextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (string) => StringUtils.formatPassword(string),
                hintText: appLocale.enterPassword),
          if (_tries > 0 && !_recoveryMode)
            Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    child: Text(appLocale.forgotPassword),
                    onPressed: () {
                      setState(() {
                        _recoveryMode = true;
                      });
                    })),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 8.0),
            child: ActionButton(
              fillColor: Constants.appBlue,
              child: _loading ? CircularProgressIndicator() : null,
              text: !_loading
                  ? _recoveryMode
                      ? appLocale.sendRecoveryMail
                      : appLocale.continueLabel
                  : null,
              onPressed: _recoveryMode
                  ? () {
                      if (!_formKey.currentState.validate()) {
                        setState(() => _loading = false);
                        return;
                      }
                      context
                          .read<AuthenticationProvider>()
                          .recoverPassword(_emailController.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              appLocale.checkInbox)));
                      Navigator.of(context).pop();
                    }
                  : () async {
                      setState(() {
                        _tries++;
                        _loading = true;
                      });
                      if (!_formKey.currentState.validate()) {
                        setState(() => _loading = false);
                        return;
                      }
                      await widget.emailCallBack(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      setState(() => _loading = false);
                    },
            ),
          ),
          ActionButton(
            text: appLocale.cancel,
            onPressed: () => Navigator.of(context).pop(),
            fillColor: Constants.appRed,
            borderColor: Colors.black,
          )
        ]),
      ),
    );
  }
}
