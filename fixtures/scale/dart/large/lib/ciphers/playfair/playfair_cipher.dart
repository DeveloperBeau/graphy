import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'playfair_digraphs.dart';
import 'playfair_key.dart';
import 'playfair_rules.dart';

/// Digraph substitution over a 5x5 keyword square.
class PlayfairCipher implements Cipher {
  final String _square;

  PlayfairCipher(PlayfairKey key) : _square = key.square();

  @override
  String name() => 'playfair';

  @override
  String encrypt(String plaintext) =>
      transformPairs(_square, splitDigraphs(cleanAlphabet(plaintext)), 1);

  @override
  String decrypt(String ciphertext) =>
      transformPairs(_square, splitDigraphs(cleanAlphabet(ciphertext)), 4);
}
