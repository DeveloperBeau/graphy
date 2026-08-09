import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'keywordsub_key.dart';

/// Monoalphabetic substitution built from a keyword-mixed alphabet.
class KeywordSubCipher implements Cipher {
  final String _mixed;

  KeywordSubCipher(KeywordSubKey key) : _mixed = key.mixedAlphabet();

  @override
  String name() => 'keywordsub';

  @override
  String encrypt(String plaintext) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(plaintext).split('')) {
      sb.write(_mixed[indexOf(c)]);
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final sb = StringBuffer();
    for (final c in cleanAlphabet(ciphertext).split('')) {
      sb.write(charAt(_mixed.indexOf(c)));
    }
    return sb.toString();
  }
}
