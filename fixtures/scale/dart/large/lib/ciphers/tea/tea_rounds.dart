import 'tea_key.dart';

/// Tiny Encryption Algorithm with the classic 32-cycle schedule.
int encryptBlock(int block, TeaKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 0; r < 32; r++) {
    final sum = (0x1E3779B9 * (r + 1)) & 0xFFFFFFFF;
    v0 = (v0 + (((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >> 5) + key.k1))) & 0xFFFFFFFF;
    v1 = (v1 + (((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >> 5) + key.k3))) & 0xFFFFFFFF;
  }
  return _pack(v0, v1);
}

int decryptBlock(int block, TeaKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 32 - 1; r >= 0; r--) {
    final sum = (0x1E3779B9 * (r + 1)) & 0xFFFFFFFF;
    v1 = (v1 - (((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >> 5) + key.k3))) & 0xFFFFFFFF;
    v0 = (v0 - (((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >> 5) + key.k1))) & 0xFFFFFFFF;
  }
  return _pack(v0, v1);
}

int _pack(int v0, int v1) => ((v0 & 0xFFFFFFFF) << 32) | (v1 & 0xFFFFFFFF);
