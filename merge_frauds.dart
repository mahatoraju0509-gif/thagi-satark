import 'dart:convert';
import 'dart:io';

void main() {
  final part1 = jsonDecode(File('assets/data/frauds_part1.json').readAsStringSync()) as List;
  final part2 = jsonDecode(File('assets/data/frauds_part2.json').readAsStringSync()) as List;
  final part3 = jsonDecode(File('assets/data/frauds_part3.json').readAsStringSync()) as List;
  final all = [...part1, ...part2, ...part3];
  File('assets/data/frauds.json').writeAsStringSync(jsonEncode(all));
  print('Done! Total: ${all.length} frauds');
}
