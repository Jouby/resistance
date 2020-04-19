import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/mission-phase-page.dart';
import 'package:the_dead_masked_company.resistance/tools/local-storage-manager.dart';
import 'package:the_dead_masked_company.resistance/tools/page-builder.dart';

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
  List<String> missions;
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
    this.missions =
        await LocalStorageManager.getListLocaleStorageData('missions');
    setState(() {
      this.missionNumber = missions.length + 1;
    });
  }

  void saveMissionResult() async {
    this.missions.add((this.result[0] >= widget.failNumber) ? 's' : 'r');
    LocalStorageManager.setListLocaleStorageData('missions', this.missions);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyStep;

    if (this.participantNumber <= 0) {
      int fail = this.result[0];
      int success = this.result[1];

      bodyStep = <Widget>[
        PageBuilder.buildTitle('RESULTAT DE LA MISSION $missionNumber'),
      ];

      if (this.step == 1) {
        bodyStep.add(new RaisedButton(
          child: Text('VOIR LES RESULTATS'),
          elevation: PageBuilder.elevationButton,
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
                PageBuilder.buildText('$success'),
                new Icon(Icons.check, color: Colors.white),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PageBuilder.buildText('$fail'),
                new Icon(Icons.clear, color: Colors.white),
              ],
            ),
          ]),
        ));

        bodyStep.add(new RaisedButton(
          child: Text('SUIVANT'),
          elevation: PageBuilder.elevationButton,
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
        PageBuilder.buildTitle(
            'Passer le téléphone au PARTICIPANT $currentPlayer'),
        this.getNextButton(),
      ];
    } else {
      bodyStep = <Widget>[
        PageBuilder.buildTitle('PARTICIPANT $currentPlayer'),
        new Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          new RaisedButton(
            child: Text('ECHEC'),
            color: Colors.red[700],
            elevation: PageBuilder.elevationButton,
            onPressed: () {
              this.vote(0);
            },
          ),
          new RaisedButton(
            child: Text('REUSSITE'),
            color: Colors.green[400],
            elevation: PageBuilder.elevationButton,
            onPressed: () {
              this.vote(1);
            },
          ),
        ]),
      ];
    }

    return PageBuilder.buildPage(context, bodyStep, 'mission.jpg');
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
      elevation: PageBuilder.elevationButton,
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
