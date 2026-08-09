import 'dart:io';

class SessionLog {
  final String logFile;

  SessionLog(String directory) : logFile = '$directory/session.log';

  void note(String message) {
    try {
      File(logFile).writeAsStringSync('${DateTime.now()} $message\n', mode: FileMode.append);
    } catch (_) {
      // A missing session log never fails the run.
    }
  }
}
