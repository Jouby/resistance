import 'package:flutter/material.dart';
import 'package:resistance/tools.dart';
import 'package:resistance/elements/progressbar.dart';
import 'package:resistance/pages/voice-phase-page.dart';
import 'package:flutter/foundation.dart';

class DiscoveryPhasePage extends StatefulWidget {
  final List<String> characters;
  DiscoveryPhasePage({Key key, @required this.characters}) : super(key: key);

  @override
  _DiscoveryPhasePageState createState() => new _DiscoveryPhasePageState();
}

class _DiscoveryPhasePageState extends State<DiscoveryPhasePage> {
  int step = 1;
  int currentPlayer = 1;
  int charactersCount = 0;
  List<String> characters = [];

  @override
  void initState() {
    super.initState();
    this.charactersCount = widget.characters.length;
    this.characters = widget.characters;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

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

      if (this.characters.length <= 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VoicePhasePage(charactersCount: this.charactersCount)),
        );
      }
    });
  }
}
