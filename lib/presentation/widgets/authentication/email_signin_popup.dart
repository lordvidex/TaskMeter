import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils/string_utils.dart';
import '../../../locale/locales.dart';
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

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
          CustomTextFormField(
            controller: _emailController,
            validator: (string) => StringUtils.formatMail(string.trim()),
            hintText: appLocale.enterEmail,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (string) => StringUtils.formatPassword(string),
              hintText: appLocale.enterPassword),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 8.0),
            child: ActionButton(
              fillColor: Constants.appBlue,
              text: 'Continue',
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                widget.emailCallBack(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
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
