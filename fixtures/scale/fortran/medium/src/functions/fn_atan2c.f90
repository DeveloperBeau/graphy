module fn_atan2c
  ! Two-argument arctangent.
  implicit none

contains

  function calc_atan2c(a, b) result(y)
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    y = atan2(a, b)
  end function calc_atan2c

end module fn_atan2c
