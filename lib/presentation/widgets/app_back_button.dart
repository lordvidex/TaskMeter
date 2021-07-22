import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants.dart';

class AppBackButton extends StatelessWidget {
  final Function() onPressed;
  AppBackButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextButton(
      style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 14, 30, 14)),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      child: SvgPicture.asset('assets/icons/back.svg',
          width: 29,
          height: 24,
          color: isDarkMode ? Colors.white : Constants.appNavyBlue),
    );
  }
}
