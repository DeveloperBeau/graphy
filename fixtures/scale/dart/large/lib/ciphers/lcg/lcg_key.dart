class LcgKey {
  final int seed;

  LcgKey(this.seed);

  LcgKey withStride(int stride) => LcgKey(seed + stride);

  factory LcgKey.defaultKey() => LcgKey(0x0DDC0FFE);
}
