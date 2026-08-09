class Document {
  final List<String> lines;

  Document._(this.lines);

  factory Document.fromText(String text) {
    final lines = text.split('\n').map((l) => l.trimRight()).toList();
    return Document._(lines);
  }

  int get longestLine =>
      lines.isEmpty ? 0 : lines.map((l) => l.length).reduce((a, b) => a > b ? a : b);
}
