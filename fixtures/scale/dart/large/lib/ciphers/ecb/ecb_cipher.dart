import '../../core/cipher.dart';
import '../feistel/feistel_cipher.dart';
import '../feistel/feistel_key.dart';
import 'ecb_key.dart';

/// Electronic codebook: each block enciphered independently.
class EcbModeCipher implements Cipher {
  final FeistelCipher _block;

  EcbModeCipher(EcbModeKey key) : _block = FeistelCipher(FeistelKey(key.blockKey));

  @override
  String name() => 'ecb';

  @override
  String encrypt(String plaintext) => _block.encrypt(plaintext);

  @override
  String decrypt(String ciphertext) => _block.decrypt(ciphertext);
}
