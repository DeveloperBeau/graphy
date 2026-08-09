import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'columnar_key.dart';

class ColumnarCipher implements Cipher {
  final ColumnarKey key;
  final List<int> _order;

  ColumnarCipher(this.key) : _order = key.columnOrder();

  @override
  String name() => 'columnar';

  /// Write in rows, read the columns in keyword order.
  @override
  String encrypt(String plaintext) {
    final text = key.padded(cleanAlphabet(plaintext));
    final sb = StringBuffer();
    for (final col in _order) {
      var row = 0;
      while (row * _order.length + col < text.length) {
        sb.write(text[row * _order.length + col]);
        row++;
      }
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final text = cleanAlphabet(ciphertext);
    final rows = text.length ~/ _order.length;
    final out = List<String>.filled(text.length, '');
    var cursor = 0;
    for (final col in _order) {
      for (var row = 0; row < rows; row++) {
        out[row * _order.length + col] = text[cursor++];
      }
    }
    return out.join();
  }
}
