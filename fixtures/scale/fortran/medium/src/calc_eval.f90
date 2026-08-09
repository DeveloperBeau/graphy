module calc_eval
  use calc_tokens
  use calc_lexer
  use calc_parser
  use calc_funcs_trig
  use calc_funcs_hyper
  use calc_funcs_round
  use calc_funcs_shape
  implicit none

contains

  function eval_expr(expr) result(value)
    character(len=*), intent(in) :: expr
    real(kind=8) :: value
    type(token_t) :: tokens(64)
    integer :: count, cursor
    call scan_tokens(expr, tokens, count)
    cursor = 1
    value = parse_expression(tokens, count, cursor, 1)
  end function eval_expr

  function eval_function(name, x) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    select case (trim(name))
    case ("sin", "cos", "tan", "asin", "acos", "atan")
      y = dispatch_trig(name, x)
    case ("sinh", "cosh", "tanh", "exp", "ln", "log10")
      y = dispatch_hyper(name, x)
    case ("floor", "ceil", "round", "trunc", "abs", "sign")
      y = dispatch_round(name, x)
    case default
      y = dispatch_shape(name, x)
    end select
  end function eval_function

end module calc_eval
