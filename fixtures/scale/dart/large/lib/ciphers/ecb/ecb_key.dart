class EcbModeKey {
  final int blockKey;

  EcbModeKey(this.blockKey);

  EcbModeKey rotated() => EcbModeKey(((blockKey << 8) | (blockKey >> 24)) & 0xFFFFFFFF);

  factory EcbModeKey.defaultKey() => EcbModeKey(0x5115ABED);
}
