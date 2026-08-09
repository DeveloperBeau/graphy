import 'expr.dart';

class UnaryExpr implements Expr {
  final String operator;
  final Expr operand;

  UnaryExpr(this.operator, this.operand);

  @override
  String describe() => '$operator${operand.describe()}';

  bool get isNegation => operator == '-';
}
