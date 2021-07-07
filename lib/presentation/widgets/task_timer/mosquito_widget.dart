import 'package:flutter/material.dart';

class MosquitoWidgetController {
  final List<AnimationController> _controllers;
  MosquitoWidgetController() : _controllers = [];

  void addController(AnimationController controller) {
    _controllers.add(controller);
  }

  void pause() {
    _controllers.forEach((element) => element.stop());
  }

  void resume() {
    _controllers.forEach((controller) => controller.forward());
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
  }
}

class MosquitoWidget extends StatefulWidget {
  final double lowerBoundX;
  final double upperBoundX;
  final double lowerBoundY;
  final double upperBoundY;
  final MosquitoWidgetController controller;
  final Widget child;
  final bool fasterX;
  const MosquitoWidget({
    Key key,
    @required this.child,
    this.fasterX = true,
    @required this.controller,
    @required this.lowerBoundX,
    @required this.upperBoundX,
    @required this.lowerBoundY,
    @required this.upperBoundY,
  }) : super(key: key);

  @override
  _MosquitoWidgetState createState() => _MosquitoWidgetState();
}

class _MosquitoWidgetState extends State<MosquitoWidget>
    with TickerProviderStateMixin {
  AnimationController xController;
  AnimationController yController;
  Animation<double> xAnimation;
  Animation<double> yAnimation;
  @override
  void initState() {
    xController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.fasterX ? 5 : 8));
    yController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.fasterX ? 8 : 5));
    widget.controller.addController(xController);
    widget.controller.addController(yController);
    xAnimation = Tween(begin: widget.lowerBoundX, end: widget.upperBoundX)
        .animate(xController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              xController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              xController.forward();
            }
          });
    yAnimation = Tween(begin: widget.lowerBoundY, end: widget.upperBoundY)
        .animate(yController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              yController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              yController.forward();
            }
          });
    xController.forward();
    yController.forward();
    super.initState();
  }

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: xAnimation,
        child: widget.child,
        builder: (ctx, child) => Transform.translate(
              offset: Offset(xAnimation.value, yAnimation.value),
              child: child,
            ));
  }
}
