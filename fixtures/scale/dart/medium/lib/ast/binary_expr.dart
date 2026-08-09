import 'expr.dart';

class BinaryExpr implements Expr {
  final String operator;
  final Expr left;
  final Expr right;

  BinaryExpr(this.operator, this.left, this.right);

  @override
  String describe() => '(${left.describe()} $operator ${right.describe()})';
}
