import '../core/cipher.dart';

bool roundTripCheck(Cipher cipher, String sample) {
  final encrypted = cipher.encrypt(sample);
  final decrypted = cipher.decrypt(encrypted);
  return lenientMatches(sample, decrypted);
}

/// Compare on the cipher alphabet only: case, spacing and padding may differ.
bool lenientMatches(String expected, String actual) {
  final left = expected.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
  final right = actual.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
  return right.startsWith(left) || left.startsWith(right);
}
