import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translator extends StatelessWidget {
  static List<List<dynamic>> data;

  @protected
  Widget build(BuildContext context) {
    loadAsset();
    return null;
  }

  static loadAsset() async {
    if (data == null) {
      final myData = await rootBundle.loadString("assets/sales.csv");
      data = CsvToListConverter().convert(myData);
    }
  }

  static String translate(String translateKey) {
    loadAsset();

    for (List<dynamic> line in data) {
      String lineKey = line[0];
      String lineTranslate = line[1];

      if (lineKey == translateKey) {
        return lineTranslate;
      }
    }

    return translateKey;
  }
}
