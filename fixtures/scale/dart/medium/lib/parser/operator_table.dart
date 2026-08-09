import '../errors/eval_exception.dart';
import '../util/double_compare.dart';
import 'dart:math' as math;

double applyOperator(String op, double left, double right) {
  switch (op) {
    case '+':
      return left + right;
    case '-':
      return left - right;
    case '*':
      return left * right;
    case '/':
      if (nearlyZero(right)) throw EvalException('division by zero');
      return left / right;
    case '%':
      return left % right;
    case '^':
      return math.pow(left, right).toDouble();
    default:
      throw EvalException('unknown operator $op');
  }
}
