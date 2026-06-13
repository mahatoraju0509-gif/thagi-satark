import 'dart:convert';
import 'dart:io';

void main() {
  final allQuestions = [];
  final ranges = [
    [1, 100], [101, 200], [201, 300], [301, 400], [401, 500],
    [501, 600], [601, 700], [701, 800], [801, 900], [901, 1000]
  ];
  for (final range in ranges) {
    final file = File('assets/data/quiz/questions_${range[0]}_${range[1]}.json');
    if (file.existsSync()) {
      final list = jsonDecode(file.readAsStringSync()) as List;
      allQuestions.addAll(list);
      print('Loaded: ${range[0]}-${range[1]} (${list.length} questions)');
    } else {
      print('Missing: questions_${range[0]}_${range[1]}.json');
    }
  }
  File('assets/data/quiz/all_questions.json').writeAsStringSync(jsonEncode(allQuestions));
  print('Total: ${allQuestions.length} questions merged!');
}
