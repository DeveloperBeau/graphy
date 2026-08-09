import 'dart:typed_data';

class CbcModeKey {
  final int blockKey;

  CbcModeKey(this.blockKey);

  Uint8List iv() {
    final out = Uint8List(8);
    var v = (blockKey * 0x1E3779B9) & 0xFFFFFFFFFFFFFFFF;
    for (var i = 7; i >= 0; i--) {
      out[i] = v & 0xFF;
      v >>= 8;
    }
    return out;
  }

  factory CbcModeKey.defaultKey() => CbcModeKey(0x5115ABED);
}
