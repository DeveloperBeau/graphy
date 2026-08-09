module fn_sinh
  ! Hyperbolic sine.
  implicit none

contains

  function calc_sinh(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = sinh(x)
  end function calc_sinh

end module fn_sinh
