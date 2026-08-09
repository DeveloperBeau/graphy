import '../../core/cipher.dart';
import '../../util/block_codec.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'tea_key.dart';
import 'tea_rounds.dart';

class TeaCipher implements Cipher {
  final TeaKey key;

  TeaCipher(this.key);

  @override
  String name() => 'tea';

  @override
  String encrypt(String plaintext) {
    final data = padBytes(bytesOf(plaintext), 8);
    for (var off = 0; off < data.length; off += 8) {
      writeBlock(data, off, encryptBlock(readBlock(data, off), key));
    }
    return hexEncode(data);
  }

  @override
  String decrypt(String ciphertext) {
    final data = hexDecode(ciphertext);
    for (var off = 0; off < data.length; off += 8) {
      writeBlock(data, off, decryptBlock(readBlock(data, off), key));
    }
    return bytesToText(data).trim();
  }
}
