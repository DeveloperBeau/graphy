module calc_lexer
  use calc_tokens
  use calc_lexer_util
  implicit none

contains

  subroutine scan_tokens(expr, tokens, count)
    character(len=*), intent(in) :: expr
    type(token_t), intent(out) :: tokens(:)
    integer, intent(out) :: count
    integer :: i
    character(len=1) :: c
    count = 0
    i = 1
    do while (i <= len_trim(expr))
      c = expr(i:i)
      if (c == " ") then
        i = i + 1
      else if (is_digit_char(c)) then
        call scan_number(expr, i, tokens, count)
      else
        count = count + 1
        tokens(count) = token_make("op", c)
        i = i + 1
      end if
    end do
  end subroutine scan_tokens

end module calc_lexer
