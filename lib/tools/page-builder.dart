import 'package:flutter/material.dart';
import 'package:the_dead_masked_company.resistance/pages/home-page.dart';

abstract class PageBuilder extends StatelessWidget {
  static double elevationButton = 5.0;

  static Widget buildPage(BuildContext context, List<Widget> body,
      [String image = 'briefing.jpg',
      MainAxisAlignment alignment = MainAxisAlignment.center]) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Align(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new FlatButton.icon(
                onPressed: () {
                  goBackHome(context);
                },
                icon: Icon(Icons.home, color: Colors.white),
                label: new Text('')),
          ],
        )),
        backgroundColor: Colors.black45,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/$image"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: body,
          ))),
    );
  }

  static void goBackHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  static Text buildTitle(text) {
    return new Text(
      text,
      style:
          TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: 'Nunito'),
      textAlign: TextAlign.center,
    );
  }

  static Text buildText(text) {
    return new Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
      textAlign: TextAlign.center,
    );
  }

  static Wrap getButtonList(List list) {
    return new Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        direction: Axis.horizontal, // main axis (rows or columns)
        children: list);
  }
}
