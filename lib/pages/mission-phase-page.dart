import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/vote-phase-page.dart';
import 'package:the_dead_masked_company.resistance/tools.dart';

class MissionPhasePage extends StatefulWidget {
  MissionPhasePage({Key key}) : super(key: key);

  @override
  _MissionPhasePageState createState() => new _MissionPhasePageState();
}

class _MissionPhasePageState extends State<MissionPhasePage> {
  int missionNumber; // from locale storage
  int rejectedCount = 5;
  int participantNumber;
  int failNumber;
  Map<String, int> missionResult = {"fail": 0, "success": 0};

  int totalFail = 0;
  int totalSuccess = 0;

  void getLocaleStorageData() async {
    this.missionNumber = await GamePage.getLocaleStorageData('mission-number');
    int playerCount = await GamePage.getLocaleStorageData('player-count');
    this.totalFail = await GamePage.getLocaleStorageData('mission-result-fail');
    this.totalSuccess =
        await GamePage.getLocaleStorageData('mission-result-success');

    debugPrint('playerCount' + playerCount.toString());
    Map<String, int> missionData = this.getMissionsData(playerCount);

    if (missionData != null) {
      this.participantNumber = missionData['number'];
      this.failNumber = missionData['fail'];
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getLocaleStorageData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    debugPrint('fail' + this.totalFail.toString());
    debugPrint('success' + this.totalSuccess.toString());

    if (this.totalFail >= 3) {
      return this.getStepWin(0);
    } else if (this.totalSuccess >= 3) {
      return this.getStepWin(1);
    }

    if (this.rejectedCount <= 0) {
      return this.getStepWin(0);
    }

    bodyStep = <Widget>[
      new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GamePage.buildTitle('MISSION $missionNumber'),
          Container(
            color: Colors.red[700],
            child:
                new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GamePage.buildText('$participantNumber'),
                  new Icon(Icons.supervisor_account, color: Colors.white),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GamePage.buildText('$failNumber'),
                  new Icon(Icons.warning, color: Colors.white),
                ],
              ),
            ]),
          ),

          //TODO play a card ??
          GamePage.buildText('1. Le meneur constitue une équipe'),
          GamePage.buildText(
              '2. Une fois l\'équipe composée, on passe à l\'étape des votes.'),
          GamePage.buildText('3. Résultats des votes :'),
          new RaisedButton(
            child: Text('EQUIPE ACCEPTEE'),
            color: Colors.green[400],
            elevation: GamePage.elevationButton,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VotePhasePage(
                        failNumber: this.failNumber,
                        participantNumber: this.participantNumber)),
              );
            },
          ),
          new RaisedButton(
            child: Text('EQUIPE REJETEE (plus que $rejectedCount)'),
            color: Colors.red[700],
            elevation: GamePage.elevationButton,
            onPressed: () {
              setState(() {
                this.rejectedCount--;
              });
            },
          ),
        ],
      )),
      new Row()
    ];

    return GamePage.buildPage(
        context, bodyStep, MainAxisAlignment.spaceBetween);
  }

  Widget getStepWin(int winSide) {
    String text;

    if (winSide == 0) {
      text = 'LES TERRORISTES REMPORTENT LA PARTIE';
    } else if (winSide == 1) {
      text = 'LES RESISTANTS REMPORTENT LA PARTIE';
    }

    List<Widget> bodyStep = <Widget>[
      GamePage.buildTitle(text),
      new RaisedButton(
        child: Text('Retour au menu principal'),
        elevation: GamePage.elevationButton,
        onPressed: () {
          GamePage.goBackHome(context);
        },
      ),
    ];

    return GamePage.buildPage(context, bodyStep);
  }

  Map<String, int> getMissionsData(int playerCount) {
    Map<int, Map<String, int>> missionData;

    switch (playerCount) {
      case 5:
        missionData = {
          1: {'number': 2, 'fail': 1},
          2: {'number': 3, 'fail': 1},
          3: {'number': 2, 'fail': 1},
          4: {'number': 3, 'fail': 1},
          5: {'number': 3, 'fail': 1},
        };
        break;
      case 6:
        missionData = {
          1: {'number': 2, 'fail': 1},
          2: {'number': 3, 'fail': 1},
          3: {'number': 4, 'fail': 1},
          4: {'number': 3, 'fail': 1},
          5: {'number': 4, 'fail': 1},
        };
        break;
      case 7:
        missionData = {
          1: {'number': 2, 'fail': 1},
          2: {'number': 3, 'fail': 1},
          3: {'number': 3, 'fail': 1},
          4: {'number': 5, 'fail': 2},
          5: {'number': 4, 'fail': 1},
        };
        break;
      case 8:
        missionData = {
          1: {'number': 3, 'fail': 1},
          2: {'number': 4, 'fail': 1},
          3: {'number': 4, 'fail': 1},
          4: {'number': 5, 'fail': 2},
          5: {'number': 5, 'fail': 1},
        };
        break;
      case 9:
        missionData = {
          1: {'number': 3, 'fail': 1},
          2: {'number': 4, 'fail': 1},
          3: {'number': 4, 'fail': 1},
          4: {'number': 5, 'fail': 2},
          5: {'number': 5, 'fail': 1},
        };
        break;
      case 10:
        missionData = {
          1: {'number': 3, 'fail': 1},
          2: {'number': 4, 'fail': 1},
          3: {'number': 4, 'fail': 1},
          4: {'number': 5, 'fail': 2},
          5: {'number': 5, 'fail': 1},
        };
        break;
      default:
        missionData = null;
    }

    return missionData[this.missionNumber];
  }
}
