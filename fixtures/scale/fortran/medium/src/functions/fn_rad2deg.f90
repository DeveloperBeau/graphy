module fn_rad2deg
  ! Radians to degrees.
  implicit none

contains

  function calc_rad2deg(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = x * 180.0d0 / acos(-1.0d0)
  end function calc_rad2deg

end module fn_rad2deg
