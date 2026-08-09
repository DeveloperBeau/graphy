class Rot13Key {
  final int rounds;

  Rot13Key(this.rounds);

  bool isIdentity() => rounds % 2 == 0;

  factory Rot13Key.defaultKey() => Rot13Key(1);
}
