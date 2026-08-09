import 'xtea_key.dart';

/// XTEA: TEA with a corrected key schedule mixing.
int encryptBlock(int block, XteaKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 0; r < 32; r++) {
    final sum = (0x1E3779B9 * r) & 0xFFFFFFFF;
    v0 = (v0 + ((((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key.k(sum & 3)))) & 0xFFFFFFFF;
    v1 = (v1 + ((((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key.k((sum >> 11) & 3)))) & 0xFFFFFFFF;
  }
  return _pack(v0, v1);
}

int decryptBlock(int block, XteaKey key) {
  var v0 = (block >> 32) & 0xFFFFFFFF;
  var v1 = block & 0xFFFFFFFF;
  for (var r = 32 - 1; r >= 0; r--) {
    final sum = (0x1E3779B9 * (r + 1)) & 0xFFFFFFFF;
    v1 = (v1 - ((((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key.k((sum >> 11) & 3)))) & 0xFFFFFFFF;
    v0 = (v0 - ((((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key.k(sum & 3)))) & 0xFFFFFFFF;
  }
  return _pack(v0, v1);
}

int _pack(int v0, int v1) => ((v0 & 0xFFFFFFFF) << 32) | (v1 & 0xFFFFFFFF);
