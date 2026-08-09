import '../../core/cipher.dart';
import '../polybius/polybius_cipher.dart';
import '../polybius/polybius_key.dart';
import 'bifid_key.dart';

/// Polybius coordinates split into rows, recombined after transposition.
class BifidCipher implements Cipher {
  final PolybiusCipher _coordinates;

  BifidCipher(BifidKey key) : _coordinates = PolybiusCipher(PolybiusKey(key.seedWord));

  @override
  String name() => 'bifid';

  @override
  String encrypt(String plaintext) {
    final digits = _coordinates.encrypt(plaintext);
    final rows = StringBuffer();
    final cols = StringBuffer();
    for (var i = 0; i + 1 < digits.length; i += 2) {
      rows.write(digits[i]);
      cols.write(digits[i + 1]);
    }
    return _coordinates.decrypt('$rows$cols');
  }

  @override
  String decrypt(String ciphertext) {
    final digits = _coordinates.encrypt(ciphertext);
    final half = digits.length ~/ 2;
    final sb = StringBuffer();
    for (var i = 0; i < half; i++) {
      sb.write(digits[i]);
      sb.write(digits[half + i]);
    }
    return _coordinates.decrypt(sb.toString());
  }
}
