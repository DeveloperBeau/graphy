import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'affine_key.dart';

/// Maps x to (a*x + b) mod 26; a must be coprime with 26.
class AffineCipher implements Cipher {
  final AffineKey key;

  AffineCipher(this.key);

  @override
  String name() => 'affine';

  @override
  String encrypt(String plaintext) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(plaintext).split('')) {
      sb.write(charAt(key.a * indexOf(c) + key.b));
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final inverse = key.inverseOfA();
    final sb = StringBuffer();
    for (final c in cleanAlphabet(ciphertext).split('')) {
      sb.write(charAt(inverse * (indexOf(c) - key.b)));
    }
    return sb.toString();
  }
}
