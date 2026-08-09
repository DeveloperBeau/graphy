class MyszkowskiKey {
  final String keyword;

  MyszkowskiKey(this.keyword);

  bool hasRepeats() => keyword.split('').toSet().length < keyword.length;

  factory MyszkowskiKey.defaultKey() => MyszkowskiKey('TOMATO');
}
