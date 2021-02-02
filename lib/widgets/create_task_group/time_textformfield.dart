import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeTextFormField extends StatelessWidget {
  const TimeTextFormField({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 45,
        height: 30,
        child: TextFormField(
          validator: (string) {
            if (string.isEmpty) return '??';
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(new RegExp(r'\d')),
            LengthLimitingTextInputFormatter(3)
          ],
          controller: controller,
          keyboardType: TextInputType.number,
        ));
  }
}
