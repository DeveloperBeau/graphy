module fn_tan
  ! Tangent.
  implicit none

contains

  function calc_tan(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = tan(x)
  end function calc_tan

end module fn_tan
