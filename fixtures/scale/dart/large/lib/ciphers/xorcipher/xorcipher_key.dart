class XorCipherKey {
  final String phrase;

  XorCipherKey(this.phrase);

  int phraseLength() => phrase.length;

  factory XorCipherKey.defaultKey() => XorCipherKey('drift-anchor-22');
}
