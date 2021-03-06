import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:the_dead_masked_company.resistance/pages/mission-phase-page.dart';
import 'package:the_dead_masked_company.resistance/tools/local-storage-manager.dart';
import 'package:the_dead_masked_company.resistance/tools/page-builder.dart';

enum TtsState { playing, stopped }

class VoicePhasePage extends StatefulWidget {
  final int charactersCount;
  VoicePhasePage({Key key, @required this.charactersCount}) : super(key: key);

  @override
  _VoicePhasePageState createState() => new _VoicePhasePageState();
}

class _VoicePhasePageState extends State<VoicePhasePage> {
  FlutterTts flutterTts = new FlutterTts();
  TtsState ttsState = TtsState.stopped;
  String textButton = 'START';
  bool showNextButton = false;
  IconData icon = Icons.play_arrow;

  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
    //justWait(numberOfSeconds: 1);
  }

  // void justWait({@required int numberOfSeconds}) async {
  //   await Future.delayed(Duration(seconds: numberOfSeconds));
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    flutterTts.setLanguage('fr-FR');
    flutterTts.setPitch(1);
    flutterTts.setSpeechRate(0.8);

    bodyStep = <Widget>[
      new Container(
        decoration:
            new BoxDecoration(color: new Color.fromRGBO(255, 0, 0, 0.5)),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PageBuilder.buildText(
                  'Maintenant que tous les joueurs connaissent leurs rôles le jeu va pouvoir commencer. Mettez le son assez fort, posez le téléphone au centre et appuyez sur START.'),
            ),
          ],
        ),
      ),
      new RaisedButton.icon(
        label: Text('$textButton'),
        icon: Icon(this.icon, color: Colors.black),
        elevation: PageBuilder.elevationButton,
        onPressed: () {
          setState(() {
            _speak(
                'Tout le monde ferme les yeux. Les terroristes ouvrent les yeux et se regardent.CINQ.QUATRE.TROIS.DEUX.UN.Les terroristes ferment les yeux.Tout le monde ouvrent les yeux.');
            this.textButton = 'REPLAY';
            this.showNextButton = true;
            this.icon = Icons.fast_rewind;
          });
        },
      )
    ];

    if (this.showNextButton) {
      bodyStep.add(new RaisedButton(
        child: Text('NEXT'),
        elevation: PageBuilder.elevationButton,
        onPressed: () {
          LocalStorageManager.setListLocaleStorageData('missions', List<String>());

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MissionPhasePage()),
          );
        },
      ));
    }

    return PageBuilder.buildPage(context, bodyStep);
  }
}
