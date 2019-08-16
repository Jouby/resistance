import 'package:flutter/material.dart';
import 'package:resistance/pages/home-page.dart';

abstract class GamePage extends StatelessWidget {
  static double elevationButton = 5.0;

  static Widget buildPage(context, body) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Align(
              child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_backspace, color: Colors.white),
                label: Text("Back",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
              ),
              new FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                  label: new Text('')),
            ],
          )),
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Align(
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: body,
            ),
          ),
        ),
      ),
    );
  }

  static Text buildTitle(text) {
    return new Text(
      text,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40.0),
      textAlign: TextAlign.center,
    );
  }

    static Text buildText(text) {
    return new Text(
      text,
      style: TextStyle(
          color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  static Wrap getButtonList(List list)
  {
    return new Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      direction: Axis.horizontal, // main axis (rows or columns)
      children: list
    );
  }
}
