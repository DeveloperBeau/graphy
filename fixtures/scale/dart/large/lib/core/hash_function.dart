/// A one-way digest under test. Hash suites verify determinism and check
/// for collisions across the sample corpus instead of round-tripping.
abstract class HashFunction {
  String name();

  int digest(String input);
}
