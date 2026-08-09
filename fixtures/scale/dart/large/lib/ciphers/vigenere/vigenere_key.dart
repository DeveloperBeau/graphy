class VigenereKey {
  final String keyword;

  VigenereKey(this.keyword);

  String keyCharAt(int position) => keyword[position % keyword.length];

  factory VigenereKey.defaultKey() => VigenereKey('LANTERN');
}
