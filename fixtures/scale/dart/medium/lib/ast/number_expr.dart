import 'expr.dart';

class NumberExpr implements Expr {
  final double value;

  NumberExpr(this.value);

  @override
  String describe() => value.toString();
}
