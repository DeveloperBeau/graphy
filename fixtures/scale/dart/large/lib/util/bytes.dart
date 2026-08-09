import 'dart:convert';
import 'dart:typed_data';

Uint8List bytesOf(String text) => Uint8List.fromList(utf8.encode(text));

String bytesToText(Uint8List data) => utf8.decode(data, allowMalformed: true);

Uint8List padBytes(Uint8List data, int blockSize) {
  final rem = data.length % blockSize;
  if (rem == 0) return data;
  final out = Uint8List(data.length + blockSize - rem);
  out.setRange(0, data.length, data);
  return out;
}
