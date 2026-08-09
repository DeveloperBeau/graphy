import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// Adler-32 checksum: parallel sums mod 65521.
class Adler32Hash implements HashFunction {
  @override
  String name() => 'adler32';

  @override
  int digest(String input) {
    var state = 1;
    for (final b in bytesOf(input)) {
      final high = (state >> 16) & 0xFFFF;
      final low = ((state & 0xFFFF) + b) % 65521;
      state = (((high + low) % 65521) << 16) | low;
    }
    return state;
  }
}
