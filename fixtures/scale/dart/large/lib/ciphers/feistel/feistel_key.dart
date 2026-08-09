class FeistelKey {
  final int master;

  FeistelKey(this.master);

  int subKey(int round) {
    final mixed = master ^ (0x1E3779B9 * (round + 1));
    return (mixed ^ (mixed >> 16)) & 0xFFFFFFFF;
  }

  factory FeistelKey.defaultKey() => FeistelKey(0x0F1E2D3C);
}
