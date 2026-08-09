import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'polybius_key.dart';

/// Encodes each letter as its row/column pair in a 5x5 square (J folds into I).
class PolybiusCipher implements Cipher {
  final String _square;

  PolybiusCipher(PolybiusKey key) : _square = key.square();

  @override
  String name() => 'polybius';

  @override
  String encrypt(String plaintext) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(plaintext).replaceAll('J', 'I').split('')) {
      final at = _square.indexOf(c);
      sb.write(String.fromCharCode('1'.codeUnitAt(0) + at ~/ 5));
      sb.write(String.fromCharCode('1'.codeUnitAt(0) + at % 5));
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final sb = StringBuffer();
    for (var i = 0; i + 1 < ciphertext.length; i += 2) {
      final row = ciphertext.codeUnitAt(i) - '1'.codeUnitAt(0);
      final col = ciphertext.codeUnitAt(i + 1) - '1'.codeUnitAt(0);
      sb.write(_square[row * 5 + col]);
    }
    return sb.toString();
  }
}
