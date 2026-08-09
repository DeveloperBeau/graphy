import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import '../feistel/feistel_key.dart';
import '../feistel/feistel_network.dart';
import 'cbc_chain.dart';
import 'cbc_key.dart';

/// Cipher block chaining over the Feistel block, with a fixed IV from the key.
class CbcModeCipher implements Cipher {
  final FeistelNetwork _network;
  final CbcModeKey key;

  CbcModeCipher(this.key) : _network = FeistelNetwork(FeistelKey(key.blockKey));

  @override
  String name() => 'cbc';

  @override
  String encrypt(String plaintext) {
    final data = padBytes(bytesOf(plaintext), 8);
    cbcEncrypt(_network, data, key.iv());
    return hexEncode(data);
  }

  @override
  String decrypt(String ciphertext) {
    final data = hexDecode(ciphertext);
    cbcDecrypt(_network, data, key.iv());
    return bytesToText(data).trim();
  }
}
