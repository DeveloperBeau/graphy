import 'dart:io';

import 'cli/arg_parser.dart';
import 'model/document.dart';
import 'render/renderer.dart';

void main(List<String> args) {
  final options = parseArgs(args);
  final text = positionalText(args);
  if (text.isEmpty) {
    stderr.writeln('usage: textprinter [--align=MODE] [--width=N] TEXT');
    exit(2);
  }
  final document = Document.fromText(text);
  final renderer = Renderer(options);
  print(renderer.render(document));
}
