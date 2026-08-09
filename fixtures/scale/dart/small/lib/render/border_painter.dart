import '../border/frame.dart';
import '../style/theme.dart';
import 'render_target.dart';

class BorderPainter implements RenderTarget {
  final Frame frame;

  BorderPainter(this.frame);

  @override
  String paint(List<String> body, Theme theme, int width) {
    final sb = StringBuffer();
    sb.writeln(frame.rule(width));
    for (final line in body) {
      sb.write(frame.vertical);
      sb.write(' ');
      sb.write(theme.apply(line));
      sb.write(' ');
      sb.writeln(frame.vertical);
    }
    sb.write(frame.rule(width));
    return sb.toString();
  }
}
