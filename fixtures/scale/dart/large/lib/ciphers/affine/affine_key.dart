class AffineKey {
  final int a;
  final int b;

  AffineKey(this.a, this.b);

  int inverseOfA() {
    for (var candidate = 1; candidate < 26; candidate++) {
      if ((a * candidate) % 26 == 1) return candidate;
    }
    throw StateError('a is not coprime with 26');
  }

  factory AffineKey.defaultKey() => AffineKey(5, 8);
}
