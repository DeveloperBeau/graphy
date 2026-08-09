import '../style/theme.dart';

/// Anything that can turn wrapped body lines into a full framed block.
abstract class RenderTarget {
  String paint(List<String> body, Theme theme, int width);

  String describe() => runtimeType.toString();

  bool get isBordered => true;
}
