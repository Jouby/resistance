import 'package:flutter/material.dart';
import 'package:resistance/pages/home-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class GamePage extends StatelessWidget {
  static double elevationButton = 5.0;

  static Widget buildPage(BuildContext context, List<Widget> body,
      [MainAxisAlignment alignment = MainAxisAlignment.center]) {
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
                    goBackHome(context);
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
            child: new Column(
              mainAxisAlignment: alignment,
              children: body,
            )),
      ),
    );
  }

  static void goBackHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
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
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  static Wrap getButtonList(List list) {
    return new Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        direction: Axis.horizontal, // main axis (rows or columns)
        children: list);
  }

  static Future<dynamic> getLocaleStorageData(String key,
      [dynamic defaultValue]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? (defaultValue) ?? 0;
  }

  // static Map<String, int> getLocaleStorageDataMap(String key,
  //     [dynamic defaultValue]) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   dynamic value = prefs.get(key);

  //   debugPrint('value');
  //   debugPrint(value);
  //   debugPrint(value.runtimeType.toString());
  //   debugPrint('decode value');
  //   debugPrint(jsonDecode('{"0": 0, "1": 0}').toString());
  //   debugPrint(jsonDecode(value).toString());

  //   Map<String, int> toto = Map<String, int>.from(json.decode(value));

  //   return toto;
  //   //return value != null ? json.decode(value) : (defaultValue) ?? '';
  // }

  // static void setLocaleStorageDataMap(String key, Object value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key, json.encode(value));
  // }

  static void setLocaleStorageData(String key, Object value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:
        prefs.setInt(key, value);
        break;
      case String:
        prefs.setString(key, value);
        break;
      case bool:
        prefs.setBool(key, value);
        break;
      case double:
        prefs.setDouble(key, value);
        break;
      case List:
        prefs.setStringList(key, value);
        break;
      default:
        prefs.setString(key, value.toString());
        break;
    }
  }
}
