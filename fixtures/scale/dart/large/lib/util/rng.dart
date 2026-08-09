/// xorshift64-ish generator; deterministic so runs are reproducible.
class Rng {
  int _state;

  Rng(int seed) : _state = seed == 0 ? 0x1E3779B9 : seed;

  int nextInt32() {
    var x = _state;
    x ^= (x << 13) & 0xFFFFFFFF;
    x ^= (x >> 7);
    x ^= (x << 17) & 0xFFFFFFFF;
    _state = x & 0xFFFFFFFF;
    return _state;
  }

  int nextInt(int bound) => nextInt32() % bound;
}
