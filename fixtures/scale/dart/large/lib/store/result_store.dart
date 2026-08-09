import 'dart:io';

import '../core/suite_result.dart';
import 'json_lines.dart';
import 'result_record.dart';

/// Appends one JSON line per finished suite to results/run.jsonl.
class ResultStore {
  final IOSink _sink;

  ResultStore._(this._sink);

  factory ResultStore.openAt(String directory) {
    final dir = Directory(directory)..createSync(recursive: true);
    final file = File('${dir.path}/run.jsonl');
    return ResultStore._(file.openWrite());
  }

  void append(SuiteResult result) {
    _sink.writeln(toJsonLine(ResultRecord.of(result)));
  }

  void close() {
    _sink.close();
  }
}
