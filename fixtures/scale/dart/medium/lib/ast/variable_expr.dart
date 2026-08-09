import 'expr.dart';

class VariableExpr implements Expr {
  final String name;

  VariableExpr(this.name);

  @override
  String describe() => name;

  bool get isConstantName => const {'pi', 'e', 'phi', 'tau'}.contains(name);
}
