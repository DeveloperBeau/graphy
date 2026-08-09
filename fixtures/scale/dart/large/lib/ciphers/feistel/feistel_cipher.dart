import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'feistel_key.dart';
import 'feistel_network.dart';

class FeistelCipher implements Cipher {
  final FeistelNetwork _network;

  FeistelCipher(FeistelKey key) : _network = FeistelNetwork(key);

  @override
  String name() => 'feistel';

  @override
  String encrypt(String plaintext) {
    final data = padBytes(bytesOf(plaintext), 8);
    for (var off = 0; off < data.length; off += 8) {
      _network.block(data, off, false);
    }
    return hexEncode(data);
  }

  @override
  String decrypt(String ciphertext) {
    final data = hexDecode(ciphertext);
    for (var off = 0; off < data.length; off += 8) {
      _network.block(data, off, true);
    }
    return bytesToText(data).trim();
  }
}
