import '../core/hash_function.dart';

bool stableDigest(HashFunction hash, String sample) =>
    hash.digest(sample) == hash.digest(sample);

bool distinctDigests(HashFunction hash, String left, String right) {
  if (left == right) return true;
  return hash.digest(left) != hash.digest(right);
}
