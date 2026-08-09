import 'dart:typed_data';

/// Big-endian 64-bit block packing shared by the block ciphers.
int readBlock(Uint8List data, int at) {
  var value = 0;
  for (var i = 0; i < 8; i++) {
    value = (value << 8) | data[at + i];
  }
  return value;
}

void writeBlock(Uint8List data, int at, int value) {
  var v = value;
  for (var i = 7; i >= 0; i--) {
    data[at + i] = v & 0xFF;
    v >>= 8;
  }
}
