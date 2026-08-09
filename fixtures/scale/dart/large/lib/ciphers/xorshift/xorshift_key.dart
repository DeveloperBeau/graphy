class XorShiftKey {
  final int seed;

  XorShiftKey(this.seed);

  bool isZeroSeed() => seed == 0;

  factory XorShiftKey.defaultKey() => XorShiftKey(0x1A2B3C4D);
}
