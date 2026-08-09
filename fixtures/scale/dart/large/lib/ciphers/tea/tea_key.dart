class TeaKey {
  final int k0, k1, k2, k3;

  TeaKey(this.k0, this.k1, this.k2, this.k3);

  int k(int index) {
    switch (index & 3) {
      case 0:
        return k0;
      case 1:
        return k1;
      case 2:
        return k2;
      default:
        return k3;
    }
  }

  factory TeaKey.defaultKey() => TeaKey(0x01234567, 0x1A2B3C4D, 0x1234568, 0x76543210);
}
