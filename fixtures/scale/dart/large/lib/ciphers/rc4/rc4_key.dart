class Rc4Key {
  final String secret;

  Rc4Key(this.secret);

  int secretLength() => secret.length;

  factory Rc4Key.defaultKey() => Rc4Key('quiet-basalt-9');
}
