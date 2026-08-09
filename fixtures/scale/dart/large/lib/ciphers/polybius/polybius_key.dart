class PolybiusKey {
  final String seedWord;

  PolybiusKey(this.seedWord);

  /// 25-letter square: seed word first, then the rest of the alphabet minus J.
  String square() {
    final sb = StringBuffer();
    final source = '${seedWord.toUpperCase().replaceAll('J', 'I')}ABCDEFGHIKLMNOPQRSTUVWXYZ';
    for (final c in source.split('')) {
      if (c != 'J' && !sb.toString().contains(c)) sb.write(c);
    }
    return sb.toString();
  }

  factory PolybiusKey.defaultKey() => PolybiusKey('HARBOR');
}
