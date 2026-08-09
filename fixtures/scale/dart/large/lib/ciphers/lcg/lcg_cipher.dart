import 'dart:typed_data';

import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'lcg_key.dart';

/// Keystream from a linear congruential generator seeded by the key.
class LcgCipher implements Cipher {
  final LcgKey key;

  LcgCipher(this.key);

  @override
  String name() => 'lcg';

  @override
  String encrypt(String plaintext) => hexEncode(_mask(bytesOf(plaintext)));

  @override
  String decrypt(String ciphertext) => bytesToText(_mask(hexDecode(ciphertext)));

  Uint8List _mask(Uint8List data) {
    var state = key.seed;
    final out = Uint8List(data.length);
    for (var i = 0; i < data.length; i++) {
      state = (state * 1103515245 + 12345) & 0xFFFFFFFF;
      out[i] = data[i] ^ ((state >> 16) & 0xFF);
    }
    return out;
  }
}
