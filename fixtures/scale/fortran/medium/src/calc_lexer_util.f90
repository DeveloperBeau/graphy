module calc_lexer_util
  use calc_tokens
  implicit none

contains

  function is_digit_char(c) result(ok)
    character(len=1), intent(in) :: c
    logical :: ok
    ok = (c >= "0" .and. c <= "9") .or. c == "."
  end function is_digit_char

  subroutine scan_number(expr, i, tokens, count)
    character(len=*), intent(in) :: expr
    integer, intent(inout) :: i, count
    type(token_t), intent(inout) :: tokens(:)
    integer :: start
    start = i
    do while (i <= len_trim(expr))
      if (.not. is_digit_char(expr(i:i))) exit
      i = i + 1
    end do
    count = count + 1
    tokens(count) = token_make("num", expr(start:i - 1))
  end subroutine scan_number

end module calc_lexer_util
