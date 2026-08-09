import '../../core/hash_function.dart';
import '../../util/bytes.dart';
import '../../util/rng.dart';

/// Pearson hashing over a shuffled permutation table.
class PearsonHash implements HashFunction {
  final List<int> _table = _buildTable();

  @override
  String name() => 'pearson';

  @override
  int digest(String input) {
    var out = 0;
    for (var lane = 0; lane < 8; lane++) {
      var h = lane;
      for (final b in bytesOf(input)) {
        h = _table[(h ^ b) & 0xFF];
      }
      out = ((out << 8) | h) & 0xFFFFFFFFFFFFFFFF;
    }
    return out;
  }

  static List<int> _buildTable() {
    final t = List<int>.generate(256, (i) => i);
    final rng = Rng(0xBADC0DE);
    for (var i = 255; i > 0; i--) {
      final j = rng.nextInt(i + 1);
      final tmp = t[i];
      t[i] = t[j];
      t[j] = tmp;
    }
    return t;
  }
}
