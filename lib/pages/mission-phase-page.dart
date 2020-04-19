import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/vote-phase-page.dart';
import 'package:the_dead_masked_company.resistance/tools/local-storage-manager.dart';
import 'package:the_dead_masked_company.resistance/tools/page-builder.dart';

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
  List<String> missions = [];
  Map<String, int> missionResult = {"fail": 0, "success": 0};

  void getLocaleStorageData() async {
    int playerCount =
        await LocalStorageManager.getLocaleStorageData('player-count');
    this.missions =
        await LocalStorageManager.getListLocaleStorageData('missions');

    setState(() {
      this.missionNumber = missions.length + 1;
      Map<String, int> missionData = this.getMissionsData(playerCount);

      if (missionData != null) {
        this.participantNumber = missionData['number'];
        this.failNumber = missionData['fail'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getLocaleStorageData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    if (this.missions.where((mission) => mission == 's').length >= 3) {
      return this.getStepWin(0);
    } else if (this.missions.where((mission) => mission == 'r').length >= 3) {
      return this.getStepWin(1);
    }
    if (this.rejectedCount <= 0) {
      return this.getStepWin(0);
    }

    bodyStep = <Widget>[
      SizedBox(
        height: 100.0,
        child: Stack(
          children: this.fillScoreStackImages()
        ),
      ),
      new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PageBuilder.buildTitle('MISSION $missionNumber'),
          Container(
            color: Colors.red[700],
            child:
                new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PageBuilder.buildText('$participantNumber'),
                  new Icon(Icons.supervisor_account, color: Colors.white),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PageBuilder.buildText('$failNumber'),
                  new Icon(Icons.warning, color: Colors.white),
                ],
              ),
            ]),
          ),
          PageBuilder.buildText('1. Le meneur constitue une équipe'),
          PageBuilder.buildText(
              '2. Une fois l\'équipe composée, on passe à l\'étape des votes.'),
          PageBuilder.buildText('3. Résultats des votes :'),
          SizedBox(
            width: 250,
            child: RaisedButton(
              child: Text('EQUIPE ACCEPTEE'),
              color: Colors.green[400],
              elevation: PageBuilder.elevationButton,
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
          ),
          SizedBox(
            width: 250,
            child: RaisedButton(
              child: Text('EQUIPE REJETEE (plus que $rejectedCount)'),
              color: Colors.red[700],
              elevation: PageBuilder.elevationButton,
              onPressed: () {
                setState(() {
                  this.rejectedCount--;
                });
              },
            ),
          ),
        ],
      )),
      Row()
    ];

    return PageBuilder.buildPage(
        context, bodyStep, 'mission.jpg', MainAxisAlignment.spaceBetween);
  }

  List<Widget> fillScoreStackImages() {
    List<Widget> list = [];
    List<String> imageList = ['empty'];

    String prefix = '';
    for (String mission in this.missions) {
      imageList.add(prefix + mission);
      prefix += 'x';
    }

    for (String image in imageList) {
      list.add(Positioned.fill(
        child: Container(
          child: ClipRRect(
            child: Image.asset(
              'assets/images/score/$image.png',
            ),
          ),
        ),
      ));
    }

    return list;
  }

  Widget getStepWin(int winSide) {
    String text;

    if (winSide == 0) {
      text = 'LES TERRORISTES REMPORTENT LA PARTIE';
    } else if (winSide == 1) {
      text = 'LES RESISTANTS REMPORTENT LA PARTIE';
    }

    List<Widget> bodyStep = <Widget>[
      PageBuilder.buildTitle(text),
      new RaisedButton(
        child: Text('Retour au menu principal'),
        elevation: PageBuilder.elevationButton,
        onPressed: () {
          PageBuilder.goBackHome(context);
        },
      ),
    ];

    return PageBuilder.buildPage(context, bodyStep);
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
