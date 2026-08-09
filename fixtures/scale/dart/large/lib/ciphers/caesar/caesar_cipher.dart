import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'caesar_key.dart';

/// Classic shift cipher; the key is the fixed shift amount.
class CaesarCipher implements Cipher {
  final CaesarKey key;

  CaesarCipher(this.key);

  @override
  String name() => 'caesar';

  @override
  String encrypt(String plaintext) => _shiftBy(plaintext, key.shift);

  @override
  String decrypt(String ciphertext) => _shiftBy(ciphertext, -(key.shift));

  String _shiftBy(String text, int amount) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(text).split('')) {
      sb.write(charAt(indexOf(c) + amount));
    }
    return sb.toString();
  }
}
