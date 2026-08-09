module fn_exp
  ! Natural exponent.
  implicit none

contains

  function calc_exp(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = exp(x)
  end function calc_exp

end module fn_exp
