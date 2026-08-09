class BeaufortKey {
  final String keyword;

  BeaufortKey(this.keyword);

  String keyCharAt(int position) => keyword[position % keyword.length];

  factory BeaufortKey.defaultKey() => BeaufortKey('GRANITE');
}
