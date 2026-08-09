class PortaKey {
  final String keyword;

  PortaKey(this.keyword);

  String keyCharAt(int position) => keyword[position % keyword.length];

  factory PortaKey.defaultKey() => PortaKey('MERIDIAN');
}
