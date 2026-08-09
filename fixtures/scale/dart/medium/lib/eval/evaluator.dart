import '../ast/assign_expr.dart';
import '../ast/binary_expr.dart';
import '../ast/call_expr.dart';
import '../ast/expr.dart';
import '../ast/number_expr.dart';
import '../ast/unary_expr.dart';
import '../ast/variable_expr.dart';
import '../parser/operator_table.dart';
import 'environment.dart';
import 'function_registry.dart';

class Evaluator {
  final Environment environment;
  final FunctionRegistry registry;

  Evaluator(this.environment, this.registry);

  double evaluate(Expr expr) {
    if (expr is NumberExpr) return expr.value;
    if (expr is VariableExpr) return environment.lookup(expr.name);
    if (expr is AssignExpr) {
      final value = evaluate(expr.value);
      environment.define(expr.name, value);
      return value;
    }
    if (expr is UnaryExpr) {
      final inner = evaluate(expr.operand);
      return expr.operator == '-' ? -inner : inner;
    }
    if (expr is BinaryExpr) {
      return applyOperator(expr.operator, evaluate(expr.left), evaluate(expr.right));
    }
    if (expr is CallExpr) {
      return registry.invoke(expr.function, expr.arguments.map(evaluate).toList());
    }
    throw StateError('cannot evaluate ${expr.describe()}');
  }
}
