import '../util/text_util.dart';

String alignLeft(String line, int width) => padTo(line, width);

String alignRight(String line, int width) {
  final gap = (width - line.length).clamp(0, width);
  return (' ' * gap) + line;
}

String alignCenter(String line, int width) {
  final gap = (width - line.length).clamp(0, width);
  return padTo((' ' * (gap ~/ 2)) + line, width);
}

String align(String line, int width, String mode) {
  switch (mode) {
    case 'right':
      return alignRight(line, width);
    case 'center':
      return alignCenter(line, width);
    default:
      return alignLeft(line, width);
  }
}
