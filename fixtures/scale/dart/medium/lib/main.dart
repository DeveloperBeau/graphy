import 'dart:io';

import 'io/banner.dart';
import 'repl/repl.dart';
import 'repl/session.dart';

void main() {
  print(banner());
  final session = Session();
  final repl = Repl(session);
  exit(repl.loop());
}
