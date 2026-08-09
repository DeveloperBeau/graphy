class GronsfeldKey {
  final String digits;

  GronsfeldKey(this.digits);

  int digitAt(int position) => digits.codeUnitAt(position % digits.length) - '0'.codeUnitAt(0);

  factory GronsfeldKey.defaultKey() => GronsfeldKey('31415');
}
