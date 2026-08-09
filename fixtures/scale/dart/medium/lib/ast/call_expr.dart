import 'expr.dart';

class CallExpr implements Expr {
  final String function;
  final List<Expr> arguments;

  CallExpr(this.function, this.arguments);

  @override
  String describe() => '$function/${arguments.length}';
}
