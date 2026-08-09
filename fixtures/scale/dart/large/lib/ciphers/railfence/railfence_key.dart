class RailFenceKey {
  final int rails;

  RailFenceKey(this.rails);

  int cycleLength() => 2 * (rails - 1);

  factory RailFenceKey.defaultKey() => RailFenceKey(3);
}
