class HistoryEntry {
  final String input;
  final double result;
  final DateTime at;

  HistoryEntry(this.input, this.result) : at = DateTime.now();

  String summary() => '$input = $result';
}
