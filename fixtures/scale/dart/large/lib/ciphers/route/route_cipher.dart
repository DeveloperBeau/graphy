import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'route_key.dart';

/// Writes rows left to right, reads them back boustrophedon (snake order).
class RouteCipher implements Cipher {
  final int width;

  RouteCipher(RouteKey key) : width = key.width;

  @override
  String name() => 'route';

  @override
  String encrypt(String plaintext) {
    final padded = StringBuffer(cleanAlphabet(plaintext));
    while (padded.length % width != 0) padded.write('X');
    return _snake(padded.toString());
  }

  @override
  String decrypt(String ciphertext) => _snake(cleanAlphabet(ciphertext));

  /// Reversing alternate rows is its own inverse, so both directions share it.
  String _snake(String text) {
    final sb = StringBuffer();
    var row = 0;
    while (row * width < text.length) {
      final end = (row * width + width < text.length) ? row * width + width : text.length;
      final slice = text.substring(row * width, end);
      sb.write(row % 2 == 0 ? slice : slice.split('').reversed.join());
      row++;
    }
    return sb.toString();
  }
}
