import 'package:flutter/material.dart';
import 'barcontainer.dart';
import 'dart:async';

class BarContainerAnimation extends StatefulWidget {
  @override
  _BarContainerAnimationState createState() =>
      new _BarContainerAnimationState();
}

class _BarContainerAnimationState extends State<BarContainerAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

   Future<Null> _playAnimation() async {
    try {
      await _controller.repeat().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return new BarContainer(controller: _controller.view);
  }
}