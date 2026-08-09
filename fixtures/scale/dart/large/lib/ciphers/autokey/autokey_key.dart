class AutokeyKey {
  final String primer;

  AutokeyKey(this.primer);

  int primerLength() => primer.length;

  factory AutokeyKey.defaultKey() => AutokeyKey('EMBER');
}
