import 'dart:io';

class ConsoleSink {
  void line(String text) {
    stdout.writeln(text);
  }

  void transientLine(String text) {
    stdout.write('\r$text');
  }
}
