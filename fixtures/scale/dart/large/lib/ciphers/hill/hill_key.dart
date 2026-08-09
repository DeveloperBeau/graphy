class HillKey {
  final int a, b, c, d;

  HillKey(this.a, this.b, this.c, this.d);

  List<int> matrix() => [a, b, c, d];

  List<int> inverseMatrix() {
    final det = (a * d - b * c) % 26;
    var detInv = 1;
    for (var i = 1; i < 26; i++) {
      if ((det * i) % 26 == 1) detInv = i;
    }
    return [(d * detInv) % 26, (-b * detInv) % 26, (-c * detInv) % 26, (a * detInv) % 26];
  }

  factory HillKey.defaultKey() => HillKey(3, 3, 2, 5);
}
