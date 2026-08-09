module fn_abs
  ! Absolute value.
  implicit none

contains

  function calc_abs(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = abs(x)
  end function calc_abs

end module fn_abs
