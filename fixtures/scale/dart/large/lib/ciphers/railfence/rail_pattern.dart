/// Maps character positions onto rails of the zigzag fence.
class RailPattern {
  final int rails;

  RailPattern(this.rails);

  int railCount() => rails;

  int railFor(int index) {
    final cycle = 2 * (rails - 1);
    final pos = index % cycle;
    return pos < rails ? pos : cycle - pos;
  }
}
