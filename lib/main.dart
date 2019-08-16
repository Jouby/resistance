import 'package:flutter/material.dart';
import 'package:resistance/pages/home-page.dart';
import 'package:flutter/services.dart';

void main()
{
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Resistance',
      home: new HomePage(),
    );
  }
}
