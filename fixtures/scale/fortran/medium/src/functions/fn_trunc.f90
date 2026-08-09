module fn_trunc
  ! Drop the fractional part.
  implicit none

contains

  function calc_trunc(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = real(int(x), kind=8)
  end function calc_trunc

end module fn_trunc
