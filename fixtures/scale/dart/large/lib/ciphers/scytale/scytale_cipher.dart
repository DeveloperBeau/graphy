import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'scytale_key.dart';

/// Wraps text around a rod of fixed circumference and reads down the rod.
class ScytaleCipher implements Cipher {
  final int rows;

  ScytaleCipher(ScytaleKey key) : rows = key.rows;

  @override
  String name() => 'scytale';

  @override
  String encrypt(String plaintext) {
    final padded = StringBuffer(cleanAlphabet(plaintext));
    while (padded.length % rows != 0) padded.write('X');
    final text = padded.toString();
    final cols = text.length ~/ rows;
    final sb = StringBuffer();
    for (var c = 0; c < cols; c++) {
      for (var r = 0; r < rows; r++) sb.write(text[r * cols + c]);
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final text = cleanAlphabet(ciphertext);
    final cols = text.length ~/ rows;
    final sb = StringBuffer();
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) sb.write(text[c * rows + r]);
    }
    return sb.toString();
  }
}
