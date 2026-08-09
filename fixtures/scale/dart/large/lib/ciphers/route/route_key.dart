class RouteKey {
  final int width;

  RouteKey(this.width);

  int rowCountFor(int length) => (length + width - 1) ~/ width;

  factory RouteKey.defaultKey() => RouteKey(6);
}
