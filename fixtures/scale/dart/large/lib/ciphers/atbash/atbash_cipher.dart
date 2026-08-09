import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'atbash_key.dart';

/// Mirrors the alphabet: A maps to Z, B to Y, and so on.
class AtbashCipher implements Cipher {
  // Atbash is keyless; the key type exists so the suite wiring is uniform.
  AtbashCipher(AtbashKey key);

  @override
  String name() => 'atbash';

  @override
  String encrypt(String plaintext) => _mirror(plaintext);

  @override
  String decrypt(String ciphertext) => _mirror(ciphertext);

  String _mirror(String text) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(text).split('')) {
      sb.write(charAt(alphabetSize - 1 - indexOf(c)));
    }
    return sb.toString();
  }
}
