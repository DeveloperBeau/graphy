class AtbashKey {
  final String label;

  AtbashKey(this.label);

  String describe() => 'atbash/$label';

  factory AtbashKey.defaultKey() => AtbashKey('fixed');
}
