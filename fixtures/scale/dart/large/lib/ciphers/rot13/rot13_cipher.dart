import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'rot13_key.dart';

/// Caesar with a fixed shift of 13, so encryption is its own inverse.
class Rot13Cipher implements Cipher {
  final Rot13Key key;

  Rot13Cipher(this.key);

  @override
  String name() => 'rot13';

  @override
  String encrypt(String plaintext) => _shiftBy(plaintext, 13 * key.rounds);

  @override
  String decrypt(String ciphertext) => _shiftBy(ciphertext, -(13 * key.rounds));

  String _shiftBy(String text, int amount) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(text).split('')) {
      sb.write(charAt(indexOf(c) + amount));
    }
    return sb.toString();
  }
}
