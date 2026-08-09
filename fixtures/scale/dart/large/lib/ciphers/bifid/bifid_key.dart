class BifidKey {
  final String seedWord;

  BifidKey(this.seedWord);

  int seedLength() => seedWord.length;

  factory BifidKey.defaultKey() => BifidKey('CIPHER');
}
