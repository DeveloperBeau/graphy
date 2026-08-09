import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// Bernstein's hash: state * 33 + byte.
class Djb2Hash implements HashFunction {
  @override
  String name() => 'djb2';

  @override
  int digest(String input) {
    var state = 5381;
    for (final b in bytesOf(input)) {
      state = (((state << 5) + state) + b) & 0xFFFFFFFF;
    }
    return state;
  }
}
