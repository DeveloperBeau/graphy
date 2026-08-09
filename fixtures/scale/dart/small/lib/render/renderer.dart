import '../border/frames.dart';
import '../layout/aligner.dart';
import '../layout/wrapper.dart';
import '../model/document.dart';
import '../model/render_options.dart';
import '../style/theme.dart';
import 'border_painter.dart';

class Renderer {
  final RenderOptions options;

  Renderer(this.options);

  String render(Document document) {
    final width = options.clampedWidth;
    final body = <String>[];
    for (final line in document.lines) {
      for (final piece in wrap(line, width)) {
        body.add(align(piece, width, options.align));
      }
    }
    final frame = frameNamed(options.frameName);
    final theme = Theme.named('plain');
    final painter = BorderPainter(frame);
    return painter.paint(body, theme, width);
  }
}
