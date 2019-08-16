import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
   final double height;
   final Color color;
  const Bar({this.height,this.color}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.0,
      height: this.height,
      margin: new EdgeInsets.only(left: 3.0, right: 3.0),
      decoration: new BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.circular(10.0),
      )
    );
  }
}