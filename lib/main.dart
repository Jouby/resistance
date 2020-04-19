import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_dead_masked_company.resistance/pages/home-page.dart';
import 'package:flutter/services.dart';
import 'package:the_dead_masked_company.resistance/tools/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyHome());
  });
}

class MyHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ImageCache().clear();
    return MaterialApp(
      title: 'Resistance',
      theme: ThemeData(fontFamily: 'Raleway'),
      localizationsDelegates: [
        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: I18nDelegate.supportedLocals,
      home: new HomePage(),
    );
  }
}
