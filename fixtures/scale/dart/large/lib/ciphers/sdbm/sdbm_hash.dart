import '../../core/hash_function.dart';
import '../../util/bytes.dart';

/// sdbm hash as used by the old sdbm database library.
class SdbmHash implements HashFunction {
  @override
  String name() => 'sdbm';

  @override
  int digest(String input) {
    var state = 0;
    for (final b in bytesOf(input)) {
      state = (b + (state << 6) + (state << 16) - state) & 0xFFFFFFFF;
    }
    return state;
  }
}
