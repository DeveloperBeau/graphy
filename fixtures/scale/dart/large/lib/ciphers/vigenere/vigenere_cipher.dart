import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'vigenere_key.dart';

/// Adds the repeating keyword letter to each plaintext letter.
class VigenereCipher implements Cipher {
  final VigenereKey key;

  VigenereCipher(this.key);

  @override
  String name() => 'vigenere';

  @override
  String encrypt(String plaintext) => _transform(cleanAlphabet(plaintext), true);

  @override
  String decrypt(String ciphertext) => _transform(cleanAlphabet(ciphertext), false);

  String _transform(String text, bool forward) {
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final x = indexOf(text[i]);
      final k = indexOf(key.keyCharAt(i));
      sb.write(charAt(forward ? x + k : x - k));
    }
    return sb.toString();
  }
}
