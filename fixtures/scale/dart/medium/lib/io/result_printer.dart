import '../config/settings.dart';
import 'output_formatter.dart';

class ResultPrinter {
  final OutputFormatter formatter;

  ResultPrinter(Settings settings) : formatter = OutputFormatter(settings);

  void printValue(double value) {
    print('= ${formatter.format(value)}');
  }
}
