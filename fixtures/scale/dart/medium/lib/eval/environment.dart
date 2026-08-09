import '../errors/eval_exception.dart';

class Environment {
  final Map<String, double> _variables = {};

  void define(String name, double value) {
    _variables[name] = value;
  }

  double lookup(String name) {
    final value = _variables[name];
    if (value == null) throw EvalException('unknown variable $name');
    return value;
  }

  bool isDefined(String name) => _variables.containsKey(name);

  Iterable<String> names() => _variables.keys;
}
