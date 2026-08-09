/// Splits cleaned text into Playfair digraphs, breaking doubles with X.
String splitDigraphs(String text) {
  final folded = text.replaceAll('J', 'I');
  final sb = StringBuffer();
  var i = 0;
  while (i < folded.length) {
    final first = folded[i];
    sb.write(first);
    if (i + 1 < folded.length && folded[i + 1] != first) {
      sb.write(folded[i + 1]);
      i += 2;
    } else {
      sb.write(first == 'X' ? 'Q' : 'X');
      i += 1;
    }
  }
  return sb.toString();
}
