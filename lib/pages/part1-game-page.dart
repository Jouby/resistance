import 'package:flutter/material.dart';
import 'package:resistance/tools.dart';
import 'package:resistance/elements/progressbar.dart';
import 'package:resistance/pages/part2-game-page.dart';
import 'package:flutter/foundation.dart';

class Part1GamePage extends StatefulWidget {
  final List<String> characters;
  Part1GamePage({Key key, @required this.characters}) : super(key: key);

  @override
  _Part1GamePageState createState() => new _Part1GamePageState();
}

class _Part1GamePageState extends State<Part1GamePage> {
  int step = 1;
  int currentPlayer = 1;
  int playerCount = 0;
  List<String> characters = [];

  @override
  void initState() {
    super.initState();
    this.characters = widget.characters;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    if (this.characters.length > 0) {
      if (this.step == 1) {
        bodyStep = <Widget>[
          GamePage.buildTitle('Passer le téléphone au JOUEUR $currentPlayer'),
          this.getNextButton(),
        ];
      } else {
        String randomCharacter = (this.characters..shuffle()).first;
        this.characters.remove(randomCharacter);

        bodyStep = <Widget>[
          GamePage.buildTitle(
              'JOUEUR $currentPlayer, Vous êtes $randomCharacter'),
          new Container(
            constraints: new BoxConstraints.expand(height: 100.0, width: 50.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/$randomCharacter.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          this.getNextButton(),
          new ProgressBar(callback: this.goToNext)
        ];
      }
    } else {
      bodyStep = <Widget>[
        GamePage.buildText(
            'Maintenant que tous les joueurs connaissent leurs rôles le jeu va pouvoir commencer. Mettez le son assez fort, posez le téléphone au centre et appuyez sur START.'),
        new RaisedButton(
          child: Text('START'),
          elevation: GamePage.elevationButton,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Part2GamePage()),
            );
          },
        )
      ];
    }
    return GamePage.buildPage(context, bodyStep);
  }

  RaisedButton getNextButton() {
    return new RaisedButton(
      child: Text('SUIVANT'),
      elevation: GamePage.elevationButton,
      onPressed: () {
        this.goToNext();
      },
    );
  }

  void goToNext() {
    setState(() {
      if (this.step == 2) {
        this.currentPlayer++;
        this.step = 1;
      } else {
        this.step++;
      }
    });
  }
}
