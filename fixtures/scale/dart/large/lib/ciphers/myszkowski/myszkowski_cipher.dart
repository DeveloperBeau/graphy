import '../../core/cipher.dart';
import '../columnar/columnar_cipher.dart';
import '../columnar/columnar_key.dart';
import 'myszkowski_key.dart';

/// Myszkowski transposition with a repeated-letter keyword. Equal letters
/// read left to right, realised here by delegating to a plain columnar pass
/// over the tie-broken column order.
class MyszkowskiCipher implements Cipher {
  final ColumnarCipher _delegate;

  MyszkowskiCipher(MyszkowskiKey key)
      : _delegate = ColumnarCipher(ColumnarKey(key.keyword));

  @override
  String name() => 'myszkowski';

  @override
  String encrypt(String plaintext) => _delegate.encrypt(plaintext);

  @override
  String decrypt(String ciphertext) => _delegate.decrypt(ciphertext);
}
