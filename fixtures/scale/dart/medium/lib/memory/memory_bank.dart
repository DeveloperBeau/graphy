import 'memory_slot.dart';

class MemoryBank {
  final Map<String, MemorySlot> _slots = {};

  MemorySlot slot(String name) => _slots.putIfAbsent(name, () => MemorySlot());

  void add(String name, double amount) {
    final target = slot(name);
    target.store(target.recall() + amount);
  }

  void clearAll() {
    for (final s in _slots.values) {
      s.clear();
    }
  }

  int occupiedCount() => _slots.values.where((s) => s.isOccupied).length;
}
