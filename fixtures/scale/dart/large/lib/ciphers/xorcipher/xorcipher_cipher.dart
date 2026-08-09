import 'dart:typed_data';

import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'xorcipher_key.dart';

/// Repeating-key XOR; ciphertext is hex so it stays printable.
class XorCipherCipher implements Cipher {
  final Uint8List _keyBytes;

  XorCipherCipher(XorCipherKey key) : _keyBytes = bytesOf(key.phrase);

  @override
  String name() => 'xorcipher';

  @override
  String encrypt(String plaintext) => hexEncode(_mask(bytesOf(plaintext)));

  @override
  String decrypt(String ciphertext) => bytesToText(_mask(hexDecode(ciphertext)));

  Uint8List _mask(Uint8List data) {
    final out = Uint8List(data.length);
    for (var i = 0; i < data.length; i++) {
      out[i] = data[i] ^ _keyBytes[i % _keyBytes.length];
    }
    return out;
  }
}
