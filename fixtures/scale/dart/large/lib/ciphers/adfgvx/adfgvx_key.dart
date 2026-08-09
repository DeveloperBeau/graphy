class AdfgvxKey {
  final String seedWord;
  final String transpositionWord;

  AdfgvxKey(this.seedWord, this.transpositionWord);

  /// 36-cell grid of letters and digits, seed word first.
  String grid() {
    final sb = StringBuffer();
    final source = '${seedWord.toUpperCase()}ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    for (final c in source.split('')) {
      if (!sb.toString().contains(c)) sb.write(c);
    }
    return sb.toString();
  }

  factory AdfgvxKey.defaultKey() => AdfgvxKey('NIGHTMARE', 'GERMAN');
}
