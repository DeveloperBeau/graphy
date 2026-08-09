/// Marker for every node the parser can produce. Evaluation lives in
/// eval/evaluator.dart so the tree stays plain data.
abstract class Expr {
  /// Short human-readable form used by :history and error messages.
  String describe() => runtimeType.toString();
}
