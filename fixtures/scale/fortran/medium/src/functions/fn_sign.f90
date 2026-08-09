module fn_sign
  ! Signum.
  implicit none

contains

  function calc_sign(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = sign(1.0d0, x)
  end function calc_sign

end module fn_sign
