module fn_power
  ! Exponentiation.
  implicit none

contains

  function calc_power(a, b) result(y)
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    y = a ** b
  end function calc_power

end module fn_power
