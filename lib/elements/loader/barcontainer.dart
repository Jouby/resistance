import 'package:flutter/material.dart';
import 'bar.dart';

class BarContainer extends StatelessWidget {
  BarContainer({Key key, this.controller}) : super(key: key);
  final Animation<double> controller;
  Animation<double> get stepOne =>
      new Tween<double>(begin: 1.0, end: 1.5).animate(
        new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.0,
            0.2,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepTwo =>
      new Tween<double>(begin: 1.0, end: 1.5).animate(
        new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.2,
            0.4,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double> get stepThree =>
      new Tween<double>(begin: 1.0, end: 1.5).animate(
        new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.4,
            0.6,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double> get stepFour =>
      new Tween<double>(begin: 1.0, end: 1.3).animate(
        new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.6,
            0.8,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double> get stepFive =>
      new Tween<double>(begin: 1.0, end: 1.5).animate(
        new CurvedAnimation(
          parent: controller,
          curve: new Interval(
            0.8,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );                

  Animation<Color> get stepOnecolorTween =>
      new ColorTween(
      begin: Colors.blue[400],
      end: Colors.blue,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.0, 0.20,
          curve: Curves.ease,
        ),
      ),
    );

  Animation<Color> get stepTwoColorTweeen =>
      new ColorTween(
      begin: Colors.blue[400],
      end: Colors.blue,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.20, 0.40,
          curve: Curves.ease,
        ),
      ),
    );

  Animation<Color> get stepThreeColorTween =>
      new ColorTween(
      begin: Colors.blue[400],
      end: Colors.blue,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.40, 0.60,
          curve: Curves.ease,
        ),
      ),
    );

  Animation<Color> get stepFourColorTween =>
      new ColorTween(
      begin: Colors.blue[400],
      end: Colors.blue,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.60, 0.80,
          curve: Curves.ease,
        ),
      ),
    );

  Animation<Color> get stepFiveColorTween =>
      new ColorTween(
      begin: Colors.blue[400],
      end: Colors.blue,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.80, 1.0,
          curve: Curves.ease,
        ),
      ),
    );         

  // This function is called each the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Center(
        child: new Container(
      height: 60.0,
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: new Offset(1.0, 0.0),
            ),
          ]),
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Transform.scale(
            scale: stepOne.value,
            child: new Bar(height: 20.0,color: stepOnecolorTween.value),
          ),
          new Transform.scale(
            scale: stepTwo.value,
            child: new Bar(height: 20.0,color: stepTwoColorTweeen.value),
          ),
          new Transform.scale(
            scale: stepThree.value,
            child: new Bar(height: 20.0,color: stepThreeColorTween.value),
          ),
          new Transform.scale(
            scale: stepFour.value,
            child: new Bar(height: 20.0,color: stepFourColorTween.value),
          ),
          new Transform.scale(
            scale: stepFive.value,
            child: new Bar(height: 20.0,color:stepFiveColorTween.value),
          )
          
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}