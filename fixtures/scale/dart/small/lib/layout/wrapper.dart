List<String> wrap(String line, int width) {
  final wrapped = <String>[];
  final current = StringBuffer();
  for (final word in line.split(' ')) {
    if (current.length > 0 && current.length + 1 + word.length > width) {
      wrapped.add(current.toString());
      current.clear();
    }
    if (current.length > 0) current.write(' ');
    current.write(word);
  }
  if (current.length > 0) wrapped.add(current.toString());
  return wrapped.isEmpty ? [''] : wrapped;
}
