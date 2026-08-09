class MemorySlot {
  double _value = 0.0;
  bool _occupied = false;

  void store(double newValue) {
    _value = newValue;
    _occupied = true;
  }

  double recall() => _occupied ? _value : 0.0;

  void clear() {
    _value = 0.0;
    _occupied = false;
  }

  bool get isOccupied => _occupied;
}
