class CaesarKey {
  final int shift;

  CaesarKey(this.shift);

  int normalizedShift() => ((shift % 26) + 26) % 26;

  factory CaesarKey.defaultKey() => CaesarKey(7);
}
