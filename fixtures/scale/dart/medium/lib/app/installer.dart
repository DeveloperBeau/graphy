import '../config/settings.dart';
import '../eval/function_registry.dart';
import '../funcs/combinatorics.dart';
import '../funcs/conversion.dart';
import '../funcs/exponential.dart';
import '../funcs/hyperbolic.dart';
import '../funcs/inverse_trig.dart';
import '../funcs/logarithms.dart';
import '../funcs/powers.dart';
import '../funcs/rounding.dart';
import '../funcs/stats.dart';
import '../funcs/trig.dart';

void installBuiltins(FunctionRegistry registry, Settings settings) {
  registerTrig(registry, settings);
  registerInverseTrig(registry, settings);
  registerHyperbolic(registry);
  registerExponential(registry);
  registerLogarithms(registry);
  registerPowers(registry);
  registerRounding(registry);
  registerStats(registry);
  registerCombinatorics(registry);
  registerConversion(registry);
}
