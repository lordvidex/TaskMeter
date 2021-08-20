// @dart = 2.12
import 'package:flutter/material.dart';

/// 
class ProgressOverlay extends StatelessWidget {
  final Widget child;
  final bool loading;

  const ProgressOverlay({
    Key? key,
    required this.child,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Stack(
            children: [
              child,
              Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(
                    color: Colors.grey,
                    dismissible: false,
                  )),
              Center(child: CircularProgressIndicator())
            ],
          )
        : child;
  }
}
