import 'dart:typed_data';

import '../feistel/feistel_network.dart';

/// Applies CBC chaining around the Feistel block permutation.
void cbcEncrypt(FeistelNetwork network, Uint8List data, Uint8List chain) {
  for (var off = 0; off < data.length; off += 8) {
    for (var i = 0; i < 8; i++) {
      data[off + i] = data[off + i] ^ chain[i];
    }
    network.block(data, off, false);
    chain.setRange(0, 8, data, off);
  }
}

void cbcDecrypt(FeistelNetwork network, Uint8List data, Uint8List chain) {
  for (var off = 0; off < data.length; off += 8) {
    final next = Uint8List.sublistView(data, off, off + 8).sublist(0);
    network.block(data, off, true);
    for (var i = 0; i < 8; i++) {
      data[off + i] = data[off + i] ^ chain[i];
    }
    chain.setRange(0, 8, next);
  }
}
