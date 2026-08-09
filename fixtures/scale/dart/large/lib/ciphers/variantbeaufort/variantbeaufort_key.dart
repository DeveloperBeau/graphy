class VariantBeaufortKey {
  final String keyword;

  VariantBeaufortKey(this.keyword);

  String keyCharAt(int position) => keyword[position % keyword.length];

  factory VariantBeaufortKey.defaultKey() => VariantBeaufortKey('COBALT');
}
