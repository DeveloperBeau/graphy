import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'hill_key.dart';

/// 2x2 matrix cipher over pairs of letters mod 26.
class HillCipher implements Cipher {
  final HillKey key;

  HillCipher(this.key);

  @override
  String name() => 'hill';

  @override
  String encrypt(String plaintext) => _apply(cleanAlphabet(plaintext), key.matrix());

  @override
  String decrypt(String ciphertext) => _apply(cleanAlphabet(ciphertext), key.inverseMatrix());

  String _apply(String input, List<int> m) {
    final text = input.length % 2 == 0 ? input : '${input}X';
    final sb = StringBuffer();
    for (var i = 0; i + 1 < text.length; i += 2) {
      final x = indexOf(text[i]);
      final y = indexOf(text[i + 1]);
      sb.write(charAt(m[0] * x + m[1] * y));
      sb.write(charAt(m[2] * x + m[3] * y));
    }
    return sb.toString();
  }
}
