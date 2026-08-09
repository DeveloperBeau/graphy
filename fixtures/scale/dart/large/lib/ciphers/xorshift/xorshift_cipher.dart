import 'dart:typed_data';

import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'xorshift_key.dart';

/// Keystream from a xorshift32 generator seeded by the key.
class XorShiftCipher implements Cipher {
  final XorShiftKey key;

  XorShiftCipher(this.key);

  @override
  String name() => 'xorshift';

  @override
  String encrypt(String plaintext) => hexEncode(_mask(bytesOf(plaintext)));

  @override
  String decrypt(String ciphertext) => bytesToText(_mask(hexDecode(ciphertext)));

  Uint8List _mask(Uint8List data) {
    var state = key.seed;
    final out = Uint8List(data.length);
    for (var i = 0; i < data.length; i++) {
      state ^= (state << 13) & 0xFFFFFFFF; state ^= (state >> 7); state ^= (state << 17) & 0xFFFFFFFF; state &= 0xFFFFFFFF;
      out[i] = data[i] ^ ((state >> 16) & 0xFF);
    }
    return out;
  }
}
