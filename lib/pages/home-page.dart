import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/new-game-page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration:
                  new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
                  margin: const EdgeInsets.only(bottom: 5.0),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0, bottom: 5.0),
                            child: Divider(
                              color: Colors.white,
                              height: 30,
                            )),
                      ),
                      Text("THE",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0, bottom: 5.0),
                            child: Divider(
                              color: Colors.white,
                              height: 30,
                            )),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('RESISTANCE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0))
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            padding:
                                const EdgeInsets.only(top: 5.0),
                            child: Divider(
                              color: Colors.white,
                              height: 30,
                            )),
                      ),
                      Text("★★★★★",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            padding:
                                const EdgeInsets.only(top: 5.0),
                            child: Divider(
                              color: Colors.white,
                              height: 30,
                            )),
                      ),
                    ]),
                  ]),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                ])
          ],
        ),
      ),
    );
  }
}
