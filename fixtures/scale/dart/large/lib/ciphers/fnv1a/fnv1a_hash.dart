import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// FNV-1a 64-bit-ish: xor the byte, multiply by the prime, masked to 32 bits.
class Fnv1aHash implements HashFunction {
  @override
  String name() => 'fnv1a';

  @override
  int digest(String input) {
    var state = 0x1BF29CE4;
    for (final b in bytesOf(input)) {
      state = (state ^ b) & 0xFFFFFFFF;
      state = (state * 0x1000193) & 0xFFFFFFFF;
    }
    return state;
  }
}
