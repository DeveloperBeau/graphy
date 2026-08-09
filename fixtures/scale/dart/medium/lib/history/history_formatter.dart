import 'history.dart';

const _defaultCount = 10;

String formatHistory(History history) => formatRecent(history, _defaultCount);

String formatRecent(History history, int count) {
  final lines = history.recent(count).map((e) => e.summary());
  return lines.isEmpty ? '(empty)' : lines.join('\n');
}
