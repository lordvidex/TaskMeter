import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants.dart';

class CustomTextFormField extends TextFormField {
  final String hintText;
  final String labelText;
  final bool isDarkMode;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final Function() onTap;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  CustomTextFormField({
    this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.focusNode,
    this.onTap,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.isDarkMode = false,
  }) : super(
            onFieldSubmitted: onSubmitted,
            onChanged: onChanged,
            onTap: onTap,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 18),
                labelText: labelText,
                labelStyle: TextStyle(fontSize: 18),
                border: _border(isDarkMode),
                enabledBorder: _border(isDarkMode)));

  /// TextFormFields for numbers
  factory CustomTextFormField.numbersOnly(
          {String hintText,
          @required BuildContext context,
          Function(String) onChanged,
          Function(String) onSubmitted,
          FocusNode focusNode,
          bool isDarkMode = false,
          String Function(String) validator,
          TextEditingController controller}) =>
      CustomTextFormField(
        hintText: hintText,
        onTap: () => controller.clear(),
        isDarkMode: isDarkMode,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        validator: validator,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: true),
      );

  static _border(bool isDarkMode) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: isDarkMode ? Colors.white : Constants.appNavyBlue,
        width: 1.5,
      ));
}
