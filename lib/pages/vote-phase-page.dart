import 'package:flutter/material.dart';
import 'package:resistance/pages/mission-phase-page.dart';
import 'package:resistance/tools.dart';

class VotePhasePage extends StatefulWidget {
  final int failNumber;
  final int participantNumber;

  VotePhasePage({
    Key key,
    @required this.failNumber,
    @required this.participantNumber,
  }) : super(key: key);

  @override
  _VotePhasePageState createState() => new _VotePhasePageState();
}

class _VotePhasePageState extends State<VotePhasePage> {
  int currentPlayer = 1;
  int participantNumber;
  int missionNumber;
  int step = 1;
  Map<int, int> result;

  @override
  void initState() {
    super.initState();
    this.participantNumber = widget.participantNumber;
    this.getLocaleStorageData();
    result = {
      0: 0,
      1: 0,
    };
  }

  void getLocaleStorageData() async {
    this.missionNumber = await GamePage.getLocaleStorageData('mission-number');
    setState(() {});
  }

  void saveMissionResult() async {
    // var failureList =
    //     this.result.where((participantResult) => participantResult == 0);
    String key;
    if (this.result[0] >= widget.failNumber) {
      key = 'mission-result-fail';
    } else {
      key = 'mission-result-success';
    }

    int value = await GamePage.getLocaleStorageData(key);
    GamePage.setLocaleStorageData(key, value + 1);

    int test = value + 1;
    debugPrint('save mission result');
    debugPrint(test.toString());

    int missionNumber =
        await GamePage.getLocaleStorageData('mission-number', 1);
    GamePage.setLocaleStorageData('mission-number', missionNumber + 1);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    if (this.participantNumber <= 0) {
      int fail = this.result[0];
      int success = this.result[1];

      bodyStep = <Widget>[
        GamePage.buildTitle('RESULTAT DE LA MISSION $missionNumber'),
      ];

      if (this.step == 1) {
        bodyStep.add(new RaisedButton(
          child: Text('VOIR LES RESULTATS'),
          elevation: GamePage.elevationButton,
          onPressed: () {
            this.goToNext();
          },
        ));
      } else {
        bodyStep.add(Container(
          color: Colors.red[700],
          child:
              new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GamePage.buildText('$success'),
                new Icon(Icons.check, color: Colors.white),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GamePage.buildText('$fail'),
                new Icon(Icons.clear, color: Colors.white),
              ],
            ),
          ]),
        ));

        bodyStep.add(new RaisedButton(
          child: Text('SUIVANT'),
          elevation: GamePage.elevationButton,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissionPhasePage()),
            );
          },
        ));
      }
    } else if (this.step == 1) {
      bodyStep = <Widget>[
        GamePage.buildTitle(
            'Passer le téléphone au PARTICIPANT $currentPlayer'),
        this.getNextButton(),
      ];
    } else {
      bodyStep = <Widget>[
        GamePage.buildTitle('PARTICIPANT $currentPlayer'),
        new Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          new RaisedButton(
            child: Text('ECHEC'),
            color: Colors.red[700],
            elevation: GamePage.elevationButton,
            onPressed: () {
              this.vote(0);
            },
          ),
          new RaisedButton(
            child: Text('REUSSITE'),
            color: Colors.green[400],
            elevation: GamePage.elevationButton,
            onPressed: () {
              this.vote(1);
            },
          ),
        ]),
      ];
    }

    return GamePage.buildPage(context, bodyStep);
  }

  void vote(int vote) {
    setState(() {
      this.participantNumber--;
      this.result[vote]++;
      this.goToNext();

      if (this.participantNumber <= 0) {
        this.saveMissionResult();
      }
    });
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
