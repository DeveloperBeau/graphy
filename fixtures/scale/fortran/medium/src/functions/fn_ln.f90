module fn_ln
  ! Natural logarithm.
  implicit none

contains

  function calc_ln(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = log(x)
  end function calc_ln

end module fn_ln
