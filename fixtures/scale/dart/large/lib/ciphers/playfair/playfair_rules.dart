/// The three Playfair digraph rules: same row, same column, rectangle.
String transformPairs(String square, String pairs, int step) {
  final sb = StringBuffer();
  var i = 0;
  while (i + 1 < pairs.length) {
    final a = square.indexOf(pairs[i]);
    final b = square.indexOf(pairs[i + 1]);
    if (a ~/ 5 == b ~/ 5) {
      sb.write(square[a ~/ 5 * 5 + (a + step) % 5]);
      sb.write(square[b ~/ 5 * 5 + (b + step) % 5]);
    } else if (a % 5 == b % 5) {
      sb.write(square[(a + step * 5) % 25 ~/ 5 * 5 + a % 5]);
      sb.write(square[(b + step * 5) % 25 ~/ 5 * 5 + b % 5]);
    } else {
      sb.write(square[a ~/ 5 * 5 + b % 5]);
      sb.write(square[b ~/ 5 * 5 + a % 5]);
    }
    i += 2;
  }
  return sb.toString();
}
