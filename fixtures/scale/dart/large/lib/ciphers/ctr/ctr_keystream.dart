import 'dart:typed_data';

import '../../util/block_codec.dart';
import '../feistel/feistel_network.dart';

/// Generates the counter keystream and xors it over the data.
Uint8List ctrMask(FeistelNetwork network, int nonce, Uint8List data) {
  final out = Uint8List(data.length);
  for (var off = 0; off < data.length; off += 8) {
    final counter = Uint8List(8);
    writeBlock(counter, 0, nonce + off ~/ 8);
    network.block(counter, 0, false);
    for (var i = 0; i < 8 && off + i < data.length; i++) {
      out[off + i] = data[off + i] ^ counter[i];
    }
  }
  return out;
}
