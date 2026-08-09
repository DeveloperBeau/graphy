import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// Bitwise CRC-32 with the reflected polynomial, no lookup table.
class Crc32Hash implements HashFunction {
  @override
  String name() => 'crc32';

  @override
  int digest(String input) {
    var state = 0xFFFFFFFF;
    for (final b in bytesOf(input)) {
      state = (state ^ b) & 0xFFFFFFFF;
      for (var bit = 0; bit < 8; bit++) {
        final mask = -(state & 1) & 0xFFFFFFFF;
        state = ((state >> 1) ^ (0xEDB88320 & mask)) & 0xFFFFFFFF;
      }
    }
    return state ^ 0xFFFFFFFF;
  }
}
