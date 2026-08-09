import 'dart:math' as math;

import '../eval/environment.dart';

final phi = (1 + math.sqrt(5)) / 2;
final tau = 2 * math.pi;

void seedConstants(Environment environment) {
  environment.define('pi', math.pi);
  environment.define('e', math.e);
  environment.define('phi', phi);
  environment.define('tau', tau);
}
