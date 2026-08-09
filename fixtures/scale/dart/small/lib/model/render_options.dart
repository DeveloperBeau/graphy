class RenderOptions {
  final String align;
  final int width;
  final String frameName;

  const RenderOptions({
    this.align = 'left',
    this.width = 60,
    this.frameName = 'ascii',
  });

  RenderOptions copyWith({String? align, int? width, String? frameName}) {
    return RenderOptions(
      align: align ?? this.align,
      width: width ?? this.width,
      frameName: frameName ?? this.frameName,
    );
  }

  int get clampedWidth => width.clamp(8, 200);
}
