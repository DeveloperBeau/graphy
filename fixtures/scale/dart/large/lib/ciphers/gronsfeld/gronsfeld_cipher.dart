import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'gronsfeld_key.dart';

/// Vigenere restricted to digit keys: each digit is a shift.
class GronsfeldCipher implements Cipher {
  final GronsfeldKey key;

  GronsfeldCipher(this.key);

  @override
  String name() => 'gronsfeld';

  @override
  String encrypt(String plaintext) => _transform(cleanAlphabet(plaintext), true);

  @override
  String decrypt(String ciphertext) => _transform(cleanAlphabet(ciphertext), false);

  String _transform(String text, bool forward) {
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final x = indexOf(text[i]);
      final k = key.digitAt(i);
      sb.write(charAt(forward ? x + k : x - k));
    }
    return sb.toString();
  }
}
