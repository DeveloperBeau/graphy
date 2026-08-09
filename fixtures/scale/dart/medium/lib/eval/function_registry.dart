import '../errors/eval_exception.dart';

typedef UnaryFn = double Function(double);
typedef AggregateFn = double Function(List<double>);

class FunctionRegistry {
  final Map<String, UnaryFn> _unary = {};
  final Map<String, AggregateFn> _aggregate = {};

  void addUnary(String name, UnaryFn fn) {
    _unary[name] = fn;
  }

  void addAggregate(String name, AggregateFn fn) {
    _aggregate[name] = fn;
  }

  double invoke(String name, List<double> args) {
    if (args.length == 1 && _unary.containsKey(name)) return _unary[name]!(args[0]);
    final fn = _aggregate[name];
    if (fn == null) throw EvalException('unknown function $name/${args.length}');
    return fn(args);
  }

  bool knows(String name) => _unary.containsKey(name) || _aggregate.containsKey(name);
}
