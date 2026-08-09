class PlayfairKey {
  final String keyword;

  PlayfairKey(this.keyword);

  String square() {
    final sb = StringBuffer();
    final source = '${keyword.toUpperCase().replaceAll('J', 'I')}ABCDEFGHIKLMNOPQRSTUVWXYZ';
    for (final c in source.split('')) {
      if (c != 'J' && !sb.toString().contains(c)) sb.write(c);
    }
    return sb.toString();
  }

  factory PlayfairKey.defaultKey() => PlayfairKey('MONARCHY');
}
