class CtrModeKey {
  final int blockKey;

  CtrModeKey(this.blockKey);

  int nonce() => blockKey ^ 0xC0DEC0DE;

  factory CtrModeKey.defaultKey() => CtrModeKey(0x5115ABED);
}
