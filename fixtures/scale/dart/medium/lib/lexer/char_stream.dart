class CharStream {
  final String source;
  int _index = 0;

  CharStream(this.source);

  bool get hasNext => _index < source.length;

  String peek() => source[_index];

  String next() => source[_index++];

  int get position => _index;

  void skipWhitespace() {
    while (hasNext && peek().trim().isEmpty) _index++;
  }

  String takeWhile(bool Function(String) accept) {
    final sb = StringBuffer();
    while (hasNext && accept(peek())) sb.write(next());
    return sb.toString();
  }
}
