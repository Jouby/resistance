import 'package:flutter/material.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';

class ProgressBar extends StatefulWidget {
  final Function callback;
  ProgressBar({Key key, @required this.callback}) : super(key: key);

  @override
  _ProgressBarState createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0, end: 30).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // custom code here
        widget.callback();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: IntervalProgressBar(
          direction: IntervalProgressDirection.horizontal,
          max: 30,
          progress: animation.value.toInt(),
          intervalSize: 2,
          size: Size(200, 12),
          highlightColor: Colors.grey,
          defaultColor: Colors.red,
          intervalColor: Colors.transparent,
          intervalHighlightColor: Colors.transparent,
          reverse: true,
          radius: 0),
    );
  }
}
