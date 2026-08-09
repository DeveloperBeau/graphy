import '../app/installer.dart';
import '../config/settings.dart';
import '../eval/environment.dart';
import '../eval/function_registry.dart';
import '../funcs/constants.dart';
import '../history/history.dart';

class Session {
  final Environment environment = Environment();
  final FunctionRegistry registry = FunctionRegistry();
  final History history = History(200);
  final Settings settings = Settings();

  Session() {
    _bootstrap();
  }

  void _bootstrap() {
    installBuiltins(registry, settings);
    seedConstants(environment);
  }
}
