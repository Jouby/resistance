import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/discovery-phase-page.dart';
import 'package:the_dead_masked_company.resistance/tools/local-storage-manager.dart';
import 'package:the_dead_masked_company.resistance/tools/page-builder.dart';

class NewGamePage extends StatefulWidget {
  NewGamePage({Key key}) : super(key: key);

  @override
  _NewGamePageState createState() => new _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  int playerCount;
  String gameType;
  int step = 0;
  Map<String, int> characters = {'spy': 0, 'resist': 0};

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    switch (step) {
      case 1:
        bodyStep = <Widget>[
          new Container(
            decoration:
                new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: PageBuilder.buildTitle(
                      'Type de jeu?                         '), // cheat to get full screen size
                ),
              ],
            ),
          ),
          addTypeGameButton(),
        ];
        break;
      case 2:
      //TODO save characters in share preferences

        bodyStep = <Widget>[
          new Container(
            decoration:
                new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
            margin: const EdgeInsets.only(bottom: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: PageBuilder.buildTitle('Sélectionner vos personnages'),
                ),
              ],
            ),
          ),
          addCharacterButton(),
          new RaisedButton(
            child: Text('START GAME'),
            elevation: PageBuilder.elevationButton,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DiscoveryPhasePage(
                        characters: this.rebuildCharacters(characters))),
              );
            },
          )
        ];
        break;
      default:
        bodyStep = <Widget>[
          new Container(
            decoration:
                new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
            child: new Row(
              children: <Widget>[
                Expanded(
                  child: PageBuilder.buildTitle('Combien de joueurs ?'),
                ),
              ],
            ),
          ),
          addNumberPlayerButton(),
        ];
    }

    return PageBuilder.buildPage(context, bodyStep);
  }

  Widget addNumberPlayerButton() {
    List<RaisedButton> list = new List<RaisedButton>();
    for (var i = 5; i <= 10; i++) {
      list.add(new RaisedButton(
        child: Text(i.toString()),
        elevation: PageBuilder.elevationButton,
        onPressed: () {
          setState(() {
            LocalStorageManager.setLocaleStorageData('player-count', i);
            playerCount = i;
            step = 1;
          });
        },
      ));
    }

    return PageBuilder.getButtonList(list);
  }

  Widget addTypeGameButton() {
    List<RaisedButton> list = new List<RaisedButton>();

    for (var i in ['CLASSIQUE']) {
      list.add(new RaisedButton(
        child: Text(i),
        elevation: PageBuilder.elevationButton,
        onPressed: () {
          setState(() {
            gameType = i;
            step = 2;

            calculateCharacters();
          });
        },
      ));
    }

    return PageBuilder.getButtonList(list);
  }

  Widget addCharacterButton() {
    List<FlatButton> list = new List<FlatButton>();

    for (var i in ['resist', 'spy']) {
      list.add(new FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(0.0),
          child: new Container(
            constraints: new BoxConstraints.expand(height: 100.0, width: 50.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/$i.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Text(characters[i].toString(),
                style: new TextStyle(
                  color: Colors.white,
                )),
          )));
    }
    return PageBuilder.getButtonList(list);
  }

  void calculateCharacters() {
    if (gameType == 'CLASSIQUE') {
      switch (playerCount) {
        case 5:
          characters['resist'] = 3;
          characters['spy'] = 2;
          break;
        case 6:
          characters['resist'] = 4;
          characters['spy'] = 2;
          break;
        case 7:
          characters['resist'] = 4;
          characters['spy'] = 3;
          break;
        case 8:
          characters['resist'] = 5;
          characters['spy'] = 3;
          break;
        case 9:
          characters['resist'] = 6;
          characters['spy'] = 3;
          break;
        case 10:
          characters['resist'] = 6;
          characters['spy'] = 4;
          break;
      }
    }
  }

  List<String> rebuildCharacters(Map<String, int> characters) {
    List<String> charactersList = [];

    for (int i = 0; i < characters['resist']; i++) {
      charactersList.add('resist');
    }

    for (int i = 0; i < characters['spy']; i++) {
      charactersList.add('spy');
    }

    return charactersList;
  }
}
