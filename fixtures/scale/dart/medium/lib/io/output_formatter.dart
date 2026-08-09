import '../config/settings.dart';
import '../util/number_format.dart';

class OutputFormatter {
  final Settings settings;

  OutputFormatter(this.settings);

  String format(double value) {
    if (value.isNaN) return 'undefined';
    if (value.isInfinite) return value > 0 ? 'infinity' : '-infinity';
    final text = value.toStringAsFixed(settings.precision);
    return trimTrailingZeros(text);
  }
}
