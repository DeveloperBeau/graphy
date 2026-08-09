import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import '../playfair/playfair_digraphs.dart';
import 'twosquare_key.dart';

/// Digraphs looked up across two keyword squares stacked vertically.
class TwoSquareCipher implements Cipher {
  final String _top;
  final String _bottom;

  TwoSquareCipher(TwoSquareKey key)
      : _top = key.topSquare(),
        _bottom = key.bottomSquare();

  @override
  String name() => 'twosquare';

  @override
  String encrypt(String plaintext) => _swap(splitDigraphs(cleanAlphabet(plaintext)));

  @override
  String decrypt(String ciphertext) => _swap(splitDigraphs(cleanAlphabet(ciphertext)));

  String _swap(String pairs) {
    final sb = StringBuffer();
    var i = 0;
    while (i + 1 < pairs.length) {
      final a = _top.indexOf(pairs[i]);
      final b = _bottom.indexOf(pairs[i + 1]);
      sb.write(_top[a ~/ 5 * 5 + b % 5]);
      sb.write(_bottom[b ~/ 5 * 5 + a % 5]);
      i += 2;
    }
    return sb.toString();
  }
}
