import '../history/history_formatter.dart';
import 'session.dart';

class CommandHandler {
  final Session session;

  CommandHandler(this.session);

  /// Returns false when the REPL should exit.
  bool handle(String command) {
    switch (command.trim()) {
      case ':quit':
      case ':q':
        return false;
      case ':vars':
        session.environment.names().forEach(print);
        return true;
      case ':history':
        print(formatHistory(session.history));
        return true;
      case ':degrees':
        session.settings.useDegrees();
        return true;
      default:
        print('unknown command $command');
        return true;
    }
  }
}
