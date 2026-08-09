module calc_parser
  use calc_tokens
  use calc_ops
  implicit none
contains

  recursive function parse_expression(tokens, count, cursor, min_prec) result(value)
    type(token_t), intent(in) :: tokens(:)
    integer, intent(in) :: count, min_prec
    integer, intent(inout) :: cursor
    real(kind=8) :: value
    character(len=16) :: op
    value = parse_factor(tokens, count, cursor)
    do while (cursor <= count)
      if (tokens(cursor)%kind /= "op") exit
      op = tokens(cursor)%text
      if (op_precedence(op) < min_prec) exit
      cursor = cursor + 1
      value = apply_op(op, value, parse_expression(tokens, count, cursor, op_precedence(op) + 1))
    end do
  end function parse_expression

  recursive function parse_factor(tokens, count, cursor) result(value)
    type(token_t), intent(in) :: tokens(:)
    integer, intent(in) :: count
    integer, intent(inout) :: cursor
    real(kind=8) :: value
    if (tokens(cursor)%kind == "num") then
      read(tokens(cursor)%text, *) value
      cursor = cursor + 1
    else if (tokens(cursor)%text == "-") then
      cursor = cursor + 1
      value = -parse_factor(tokens, count, cursor)
    else
      cursor = cursor + 1
      value = parse_expression(tokens, count, cursor, 1)
      cursor = cursor + 1
    end if
  end function parse_factor
end module calc_parser
