class ScytaleKey {
  final int rows;

  ScytaleKey(this.rows);

  int circumference() => rows;

  factory ScytaleKey.defaultKey() => ScytaleKey(4);
}
