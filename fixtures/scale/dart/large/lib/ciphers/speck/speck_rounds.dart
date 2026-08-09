import 'speck_key.dart';

/// Speck32-style ARX rounds: rotate, add, xor.
int encryptBlock(int block, SpeckKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 0; r < 27; r++) {
    v0 = (((v0 >> 8 | v0 << 24) & 0xFFFFFFFF) + v1) ^ key.k(r & 3); v0 &= 0xFFFFFFFF;
    v1 = ((v1 << 3 | v1 >> 29) & 0xFFFFFFFF) ^ v0;
  }
  return _pack(v0, v1);
}

int decryptBlock(int block, SpeckKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 27 - 1; r >= 0; r--) {
    v1 = ((v1 ^ v0) >> 3 | (v1 ^ v0) << 29) & 0xFFFFFFFF;
    v0 = (((v0 ^ key.k(r & 3)) - v1) & 0xFFFFFFFF); v0 = (v0 << 8 | v0 >> 24) & 0xFFFFFFFF;
  }
  return _pack(v0, v1);
}

int _pack(int v0, int v1) => ((v0 & 0xFFFFFFFF) << 32) | (v1 & 0xFFFFFFFF);
