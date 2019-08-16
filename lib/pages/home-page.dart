import 'package:flutter/material.dart';
import 'package:resistance/pages/new-game-page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Align(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'RESISTANCE',
                  //style: Theme.of(context).textTheme.display1,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40.0)
                ),
                new RaisedButton(
                  child: Text("Nouvelle partie"),
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewGamePage()),
                    );
                  },
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
