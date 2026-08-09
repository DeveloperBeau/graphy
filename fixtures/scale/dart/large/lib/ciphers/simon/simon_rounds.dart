import 'simon_key.dart';

/// Simon32-style Feistel rounds built from AND, rotate and xor.
int encryptBlock(int block, SimonKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 0; r < 32; r++) {
    final tmp = v0;
    final rot1 = (v0 << 1 | v0 >> 31) & 0xFFFFFFFF;
    final rot8 = (v0 << 8 | v0 >> 24) & 0xFFFFFFFF;
    final rot2 = (v0 << 2 | v0 >> 30) & 0xFFFFFFFF;
    v0 = (v1 ^ (rot1 & rot8) ^ rot2 ^ key.k(r & 3)) & 0xFFFFFFFF;
    v1 = tmp;
  }
  return _pack(v0, v1);
}

int decryptBlock(int block, SimonKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 32 - 1; r >= 0; r--) {
    final tmp = v1;
    final rot1 = (v1 << 1 | v1 >> 31) & 0xFFFFFFFF;
    final rot8 = (v1 << 8 | v1 >> 24) & 0xFFFFFFFF;
    final rot2 = (v1 << 2 | v1 >> 30) & 0xFFFFFFFF;
    v1 = (v0 ^ (rot1 & rot8) ^ rot2 ^ key.k(r & 3)) & 0xFFFFFFFF;
    v0 = tmp;
  }
  return _pack(v0, v1);
}

int _pack(int v0, int v1) => ((v0 & 0xFFFFFFFF) << 32) | (v1 & 0xFFFFFFFF);
