import 'dart:typed_data';

const _digits = '0123456789abcdef';

String hexEncode(Uint8List data) {
  final sb = StringBuffer();
  for (final b in data) {
    sb.write(_digits[(b >> 4) & 0xF]);
    sb.write(_digits[b & 0xF]);
  }
  return sb.toString();
}

Uint8List hexDecode(String hex) {
  final out = Uint8List(hex.length ~/ 2);
  for (var i = 0; i < out.length; i++) {
    out[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return out;
}
