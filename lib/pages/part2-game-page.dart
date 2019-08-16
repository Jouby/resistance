import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:resistance/tools.dart';
import 'package:resistance/elements/voice-generate.dart';

enum TtsState { playing, stopped }

class Part2GamePage extends StatefulWidget {
  Part2GamePage({Key key}) : super(key: key);

  @override
  _Part2GamePageState createState() => new _Part2GamePageState();
}

class _Part2GamePageState extends State<Part2GamePage> {
  FlutterTts flutterTts = new FlutterTts();
  TtsState ttsState = TtsState.stopped;

  Future _speak() async {
    var result = await flutterTts.speak("Moumour je t'aime");
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future init() async {
    List<dynamic> languages = await flutterTts.getLanguages;

    await flutterTts.setLanguage("en-US");

    await flutterTts.setSpeechRate(1.0);

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0);

    await flutterTts.isLanguageAvailable("en-US");

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    flutterTts.setLanguage("fr-FR");

    //init();

    bodyStep = <Widget>[
      //GamePage.buildTitle('Passer le téléphone au JOUEUR $currentPlayer'),
      new RaisedButton(
        child: Text('TRY VOICE'),
        elevation: GamePage.elevationButton,
        onPressed: () async {
          //new VoiceGenerate();
          _speak();
          //Tts.speak('Hello World');
        },
      ),
      //new Text(flutterTtsState),
    ];

    return GamePage.buildPage(context, bodyStep);
  }

  // Future speak() async {
  //   var result = await flutterTts.speak("Hello World");
  //   if (result == 1) setState(() => ttsState = TtsState.playing);
  // }
}
