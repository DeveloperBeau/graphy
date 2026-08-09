import 'dart:typed_data';

import '../../util/block_codec.dart';
import 'feistel_key.dart';

/// Balanced 16-round Feistel permutation over 8-byte blocks.
class FeistelNetwork {
  final FeistelKey key;

  FeistelNetwork(this.key);

  void block(Uint8List data, int off, bool reverse) {
    final packed = readBlock(data, off);
    var left = (packed >> 32) & 0xFFFFFFFF;
    var right = packed & 0xFFFFFFFF;
    for (var r = 0; r < 16; r++) {
      final round = reverse ? 15 - r : r;
      final tmp = right;
      right = left ^ _roundFn(right, key.subKey(round));
      left = tmp;
    }
    writeBlock(data, off, ((right & 0xFFFFFFFF) << 32) | (left & 0xFFFFFFFF));
  }

  int _roundFn(int half, int subKey) {
    final rotated = ((half ^ subKey) << 5 | (half ^ subKey) >> 27) & 0xFFFFFFFF;
    return (rotated * 0x1E3779B9 + subKey) & 0xFFFFFFFF;
  }
}
