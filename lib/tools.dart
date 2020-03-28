import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/home-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GamePage extends StatelessWidget {
  static double elevationButton = 5.0;
  static List<List<dynamic>> data;

  static Widget buildPage(BuildContext context, List<Widget> body,
      [MainAxisAlignment alignment = MainAxisAlignment.center]) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: body,
          )),
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
      style: TextStyle(color: Colors.white, fontSize: 20.0),
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

  static void getTranslate() {
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert('lib/translate/fr_FR.csv');
  }
}
