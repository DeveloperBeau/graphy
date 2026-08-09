import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import '../playfair/playfair_digraphs.dart';
import '../playfair/playfair_key.dart';
import 'foursquare_key.dart';

/// Plain squares on one diagonal, keyword squares on the other.
class FourSquareCipher implements Cipher {
  static final String _plain = PlayfairKey('').square();
  final FourSquareKey key;

  FourSquareCipher(this.key);

  @override
  String name() => 'foursquare';

  @override
  String encrypt(String plaintext) {
    final pairs = splitDigraphs(cleanAlphabet(plaintext));
    final sb = StringBuffer();
    for (var i = 0; i + 1 < pairs.length; i += 2) {
      final a = _plain.indexOf(pairs[i]);
      final b = _plain.indexOf(pairs[i + 1]);
      sb.write(key.upperSquare()[a ~/ 5 * 5 + b % 5]);
      sb.write(key.lowerSquare()[b ~/ 5 * 5 + a % 5]);
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final pairs = cleanAlphabet(ciphertext);
    final sb = StringBuffer();
    for (var i = 0; i + 1 < pairs.length; i += 2) {
      final a = key.upperSquare().indexOf(pairs[i]);
      final b = key.lowerSquare().indexOf(pairs[i + 1]);
      sb.write(_plain[a ~/ 5 * 5 + b % 5]);
      sb.write(_plain[b ~/ 5 * 5 + a % 5]);
    }
    return sb.toString();
  }
}
