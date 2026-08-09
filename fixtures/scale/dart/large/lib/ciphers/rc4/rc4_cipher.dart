import 'dart:typed_data';

import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import 'rc4_key.dart';

class Rc4Cipher implements Cipher {
  final Uint8List _keyBytes;

  Rc4Cipher(Rc4Key key) : _keyBytes = bytesOf(key.secret);

  @override
  String name() => 'rc4';

  @override
  String encrypt(String plaintext) => hexEncode(_stream(bytesOf(plaintext)));

  @override
  String decrypt(String ciphertext) => bytesToText(_stream(hexDecode(ciphertext)));

  Uint8List _stream(Uint8List data) {
    final s = List<int>.generate(256, (i) => i);
    var j = 0;
    for (var i = 0; i < 256; i++) {
      j = (j + s[i] + _keyBytes[i % _keyBytes.length]) & 0xFF;
      final tmp = s[i];
      s[i] = s[j];
      s[j] = tmp;
    }
    final out = Uint8List(data.length);
    var x = 0, y = 0;
    for (var n = 0; n < data.length; n++) {
      x = (x + 1) & 0xFF;
      y = (y + s[x]) & 0xFF;
      final tmp = s[x];
      s[x] = s[y];
      s[y] = tmp;
      out[n] = data[n] ^ s[(s[x] + s[y]) & 0xFF];
    }
    return out;
  }
}
