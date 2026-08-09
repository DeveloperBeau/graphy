import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'variantbeaufort_key.dart';

/// Subtracts the keyword letter on encrypt, adds it back on decrypt.
class VariantBeaufortCipher implements Cipher {
  final VariantBeaufortKey key;

  VariantBeaufortCipher(this.key);

  @override
  String name() => 'variantbeaufort';

  @override
  String encrypt(String plaintext) => _transform(cleanAlphabet(plaintext), true);

  @override
  String decrypt(String ciphertext) => _transform(cleanAlphabet(ciphertext), false);

  String _transform(String text, bool forward) {
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final x = indexOf(text[i]);
      final k = indexOf(key.keyCharAt(i));
      sb.write(charAt(forward ? x - k : x + k));
    }
    return sb.toString();
  }
}
