import 'dart:io';
import 'package:csv/csv.dart';

class Dictionary {
  Map<String, List<Map<String, String>>> data = {};
  static final String path = "learn_french/assets/dico.csv";

  Future<Map<String, List<Map<String, String>>>> init() async {
    var mixedDict = await loadCsv();
    data = {
      "Mixed": mixedDict,
      "Food": [
        {"word": "Tea", "result": "Thé"},
        {"word": "rice", "result": "riz"},
      ],
      "Basics": [
        {"word": "Bonjour", "result": "Hello"},
        {"word": "Bye", "result": "Au revoir"},
      ],
      "Travel": [
        {"word": "Hostel", "result": "Auberge"},
        {"word": "Journey", "result": "Voyage"},
      ],
      "School": [
        {"word": "Teacher", "result": "Professeure/Professeur"},
        {"word": "classmate", "result": "camarade de classe"},
      ],
    };
    return data;
  }

  Future<List<Map<String, String>>> loadCsv() async {
    final file = File(path);
    final content = await file.readAsString();

    final converter = CsvToListConverter();
    final dictCsv = converter.convert(content);

    final header = ["word", "result"];

    var mixedList = dictCsv
        .skip(1)
        .map(
          (row) => Map<String, String>.fromIterables(
            header,
            row.map((e) => e.toString()),
          ),
        )
        .toList();
    return mixedList;
  }
}
