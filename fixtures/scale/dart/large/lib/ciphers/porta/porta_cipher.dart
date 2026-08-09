import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'porta_key.dart';

/// Reciprocal cipher over half-alphabets selected by the key letter.
class PortaCipher implements Cipher {
  final PortaKey key;

  PortaCipher(this.key);

  @override
  String name() => 'porta';

  @override
  String encrypt(String plaintext) => _swapHalves(cleanAlphabet(plaintext));

  @override
  String decrypt(String ciphertext) => _swapHalves(cleanAlphabet(ciphertext));

  String _swapHalves(String text) {
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final x = indexOf(text[i]);
      final row = indexOf(key.keyCharAt(i)) ~/ 2;
      final y = x < 13 ? 13 + (x + row) % 13 : (x - 13 - row) % 13;
      sb.write(charAt(y < 0 ? y + 13 : y));
    }
    return sb.toString();
  }
}
