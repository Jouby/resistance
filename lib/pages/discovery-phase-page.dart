import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/tools.dart';
import 'package:the_dead_masked_company.resistance/elements/progressbar.dart';
import 'package:the_dead_masked_company.resistance/pages/voice-phase-page.dart';
import 'package:flutter/foundation.dart';
import 'package:the_dead_masked_company.resistance/tools/i18n.dart';

class DiscoveryPhasePage extends StatefulWidget {
  final List<String> characters;
  DiscoveryPhasePage({Key key, @required this.characters}) : super(key: key);

  @override
  _DiscoveryPhasePageState createState() => new _DiscoveryPhasePageState();
}

class _DiscoveryPhasePageState extends State<DiscoveryPhasePage> {
  int step = 1;
  int currentPlayer = 1;
  List<String> characters = [];

  @override
  void initState() {
    super.initState();
    this.characters = widget.characters;
    // TODO Use shared preferences instead of pass argument by constructor
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    if (this.step == 1) {
      bodyStep = <Widget>[
        new Container(
          decoration:
              new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
          margin: const EdgeInsets.only(bottom: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GamePage.buildTitle(
                    'Passer le téléphone au JOUEUR $currentPlayer'),
              ),
            ],
          ),
        ),
        this.getNextButton(),
      ];
    } else {
      String randomCharacterCode = (this.characters..shuffle()).first;
      String randomCharacter = (randomCharacterCode == 'resist')
          ? I18n.of(context).resist
          : I18n.of(context).spy;
      this.characters.remove(randomCharacterCode);

      bodyStep = <Widget>[
        new Container(
          decoration:
              new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
          margin: const EdgeInsets.only(bottom: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GamePage.buildTitle(
                    'JOUEUR $currentPlayer, Vous êtes $randomCharacter'),
              ),
            ],
          ),
        ),
        new Container(
          constraints: new BoxConstraints.expand(height: 100.0, width: 50.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/$randomCharacterCode.jpg'),
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
    if (this.characters.length <= 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VoicePhasePage(charactersCount: this.characters.length)),
      );
      this.step = 1;
      this.currentPlayer = 1;
    } else {
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
}
