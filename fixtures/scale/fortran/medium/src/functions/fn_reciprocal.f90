module fn_reciprocal
  ! Multiplicative inverse.
  implicit none

contains

  function calc_reciprocal(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = 1.0d0 / x
  end function calc_reciprocal

end module fn_reciprocal
