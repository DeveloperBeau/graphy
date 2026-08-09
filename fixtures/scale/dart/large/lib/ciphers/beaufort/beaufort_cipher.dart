import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'beaufort_key.dart';

/// Reciprocal variant: ciphertext is key letter minus plaintext letter.
class BeaufortCipher implements Cipher {
  final BeaufortKey key;

  BeaufortCipher(this.key);

  @override
  String name() => 'beaufort';

  @override
  String encrypt(String plaintext) => _transform(cleanAlphabet(plaintext), true);

  @override
  String decrypt(String ciphertext) => _transform(cleanAlphabet(ciphertext), false);

  String _transform(String text, bool forward) {
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final x = indexOf(text[i]);
      final k = indexOf(key.keyCharAt(i));
      sb.write(charAt(forward ? k - x : k - x));
    }
    return sb.toString();
  }
}
