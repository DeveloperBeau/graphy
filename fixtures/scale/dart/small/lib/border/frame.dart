class Frame {
  final String corner;
  final String horizontal;
  final String vertical;

  const Frame(this.corner, this.horizontal, this.vertical);

  String rule(int innerWidth) =>
      corner + (horizontal * (innerWidth + 2)) + corner;
}
