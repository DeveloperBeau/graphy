import 'calc_exception.dart';

class EvalException extends CalcException {
  EvalException(String message) : super('eval', message);

  factory EvalException.domain(String function) =>
      EvalException('$function called outside its domain');
}
