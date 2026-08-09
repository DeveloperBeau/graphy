import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'autokey_key.dart';

/// The key stream is the primer followed by the plaintext itself.
class AutokeyCipher implements Cipher {
  final AutokeyKey key;

  AutokeyCipher(this.key);

  @override
  String name() => 'autokey';

  @override
  String encrypt(String plaintext) {
    final text = cleanAlphabet(plaintext);
    final stream = key.primer + text;
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      sb.write(charAt(indexOf(text[i]) + indexOf(stream[i])));
    }
    return sb.toString();
  }

  @override
  String decrypt(String ciphertext) {
    final text = cleanAlphabet(ciphertext);
    final stream = StringBuffer(key.primer);
    final sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final plain = charAt(indexOf(text[i]) - indexOf(stream.toString()[i]));
      sb.write(plain);
      stream.write(plain);
    }
    return sb.toString();
  }
}
