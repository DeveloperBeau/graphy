import 'dart:io';

import '../app/calculator.dart';
import '../errors/calc_exception.dart';
import '../io/result_printer.dart';
import 'command_handler.dart';
import 'session.dart';

class Repl {
  final Session session;
  late final CommandHandler commands;

  Repl(this.session) {
    commands = CommandHandler(session);
  }

  int loop() {
    final calculator = Calculator(session);
    final printer = ResultPrinter(session.settings);
    String? line;
    while ((line = stdin.readLineSync()) != null) {
      final text = line!.trim();
      if (text.isEmpty) continue;
      if (text.startsWith(':')) {
        if (!commands.handle(text)) return 0;
        continue;
      }
      try {
        final value = calculator.evaluateLine(text);
        session.history.record(text, value);
        printer.printValue(value);
      } on CalcException catch (e) {
        print('error: ${e.message}');
      }
    }
    return 0;
  }
}
