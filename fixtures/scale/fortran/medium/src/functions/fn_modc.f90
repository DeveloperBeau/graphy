module fn_modc
  ! Floating point remainder.
  implicit none

contains

  function calc_modc(a, b) result(y)
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    y = mod(a, b)
  end function calc_modc

end module fn_modc
