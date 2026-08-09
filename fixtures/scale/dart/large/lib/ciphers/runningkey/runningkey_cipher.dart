import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'runningkey_key.dart';

/// Vigenere with a long passage as the key stream instead of a short word.
class RunningKeyCipher implements Cipher {
  final RunningKeyKey key;

  RunningKeyCipher(this.key);

  @override
  String name() => 'runningkey';

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
