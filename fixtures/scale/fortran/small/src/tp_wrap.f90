module tp_wrap
  implicit none

contains

  function wrap_count(text, width) result(lines)
    character(len=*), intent(in) :: text
    integer, intent(in) :: width
    integer :: lines
    lines = (len_trim(text) + width - 1) / width
  end function wrap_count

  subroutine wrap_print(text, width)
    character(len=*), intent(in) :: text
    integer, intent(in) :: width
    integer :: start, finish
    start = 1
    do while (start <= len_trim(text))
      finish = min(start + width - 1, len_trim(text))
      print *, text(start:finish)
      start = finish + 1
    end do
  end subroutine wrap_print

end module tp_wrap
