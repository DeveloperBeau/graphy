import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// Fletcher-16 style checksum widened to fit the interface.
class FletcherHash implements HashFunction {
  @override
  String name() => 'fletcher';

  @override
  int digest(String input) {
    var state = 0;
    for (final b in bytesOf(input)) {
      final sum1 = ((state & 0xFFFF) + b) % 255;
      final sum2 = ((state >> 16) + sum1) % 255;
      state = (sum2 << 16) | sum1;
    }
    return state;
  }
}
