import 'result_record.dart';

String toJsonLine(ResultRecord record) {
  final sb = StringBuffer('{');
  _field(sb, 'suite', '"${record.suite}"');
  _field(sb, 'passed', record.passed.toString());
  _field(sb, 'failed', record.failed.toString());
  _field(sb, 'millis', record.millis.toStringAsFixed(3));
  final text = sb.toString();
  return '${text.substring(0, text.length - 1)}}';
}

void _field(StringBuffer sb, String key, String value) {
  sb.write('"$key":$value,');
}
