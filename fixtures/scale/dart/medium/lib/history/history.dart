import 'history_entry.dart';

class History {
  final List<HistoryEntry> _entries = [];
  final int capacity;

  History(this.capacity);

  void record(String input, double result) {
    if (_entries.length == capacity) _entries.removeAt(0);
    _entries.add(HistoryEntry(input, result));
  }

  List<HistoryEntry> recent(int count) {
    final from = (_entries.length - count).clamp(0, _entries.length);
    return _entries.sublist(from);
  }

  int size() => _entries.length;
}
