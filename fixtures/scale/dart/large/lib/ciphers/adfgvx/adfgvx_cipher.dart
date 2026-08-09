import '../../core/cipher.dart';
import '../columnar/columnar_cipher.dart';
import '../columnar/columnar_key.dart';
import 'adfgvx_key.dart';
import 'adfgvx_symbols.dart';

/// Field cipher: substitution into ADFGVX symbols, then columnar transposition.
class AdfgvxCipher implements Cipher {
  final AdfgvxKey key;
  final ColumnarCipher _transposition;

  AdfgvxCipher(this.key) : _transposition = ColumnarCipher(ColumnarKey(key.transpositionWord));

  @override
  String name() => 'adfgvx';

  @override
  String encrypt(String plaintext) {
    final cleaned = plaintext.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    return _transposition.encrypt(substituteGrid(key.grid(), cleaned));
  }

  @override
  String decrypt(String ciphertext) =>
      unsubstituteGrid(key.grid(), _transposition.decrypt(ciphertext));
}
