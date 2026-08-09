import 'expr.dart';

class AssignExpr implements Expr {
  final String name;
  final Expr value;

  AssignExpr(this.name, this.value);

  @override
  String describe() => '$name = ${value.describe()}';
}
