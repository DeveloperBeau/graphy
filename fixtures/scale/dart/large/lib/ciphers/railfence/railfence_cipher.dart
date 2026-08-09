import '../../core/cipher.dart';
import '../../util/alphabet.dart';
import 'rail_pattern.dart';
import 'railfence_key.dart';

/// Writes the text in a zigzag across rails, then reads rail by rail.
class RailFenceCipher implements Cipher {
  final RailPattern _pattern;

  RailFenceCipher(RailFenceKey key) : _pattern = RailPattern(key.rails);

  @override
  String name() => 'railfence';

  @override
  String encrypt(String plaintext) {
    final text = cleanAlphabet(plaintext);
    final rows = List.generate(_pattern.railCount(), (_) => StringBuffer());
    for (var i = 0; i < text.length; i++) {
      rows[_pattern.railFor(i)].write(text[i]);
    }
    return rows.map((r) => r.toString()).join();
  }

  @override
  String decrypt(String ciphertext) {
    final text = cleanAlphabet(ciphertext);
    final out = List<String>.filled(text.length, '');
    var cursor = 0;
    for (var r = 0; r < _pattern.railCount(); r++) {
      for (var i = 0; i < text.length; i++) {
        if (_pattern.railFor(i) == r) out[i] = text[cursor++];
      }
    }
    return out.join();
  }
}
