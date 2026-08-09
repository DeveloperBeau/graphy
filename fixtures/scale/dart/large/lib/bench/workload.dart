import '../util/rng.dart';

/// Deterministic plaintext payloads used to size benchmark iterations.
List<String> payloads(int count) {
  final rng = Rng(0x5EED);
  return List.generate(count, (i) => randomSentence(rng, 8 + (i % 24)));
}

String randomSentence(Rng rng, int words) {
  final sb = StringBuffer();
  for (var w = 0; w < words; w++) {
    if (w > 0) sb.write(' ');
    final len = 3 + rng.nextInt(7);
    for (var c = 0; c < len; c++) {
      sb.writeCharCode('A'.codeUnitAt(0) + rng.nextInt(26));
    }
  }
  return sb.toString();
}
