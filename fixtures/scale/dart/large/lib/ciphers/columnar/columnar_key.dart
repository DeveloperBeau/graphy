class ColumnarKey {
  final String keyword;

  ColumnarKey(this.keyword);

  /// Column indexes sorted by their keyword letter, ties left to right.
  List<int> columnOrder() {
    final indexed = List.generate(keyword.length, (i) => i);
    indexed.sort((a, b) => keyword[a].compareTo(keyword[b]));
    return indexed;
  }

  /// Pads with X until the text fills whole rows.
  String padded(String text) {
    final sb = StringBuffer(text);
    while (sb.length % keyword.length != 0) sb.write('X');
    return sb.toString();
  }

  factory ColumnarKey.defaultKey() => ColumnarKey('ZEBRAS');
}
