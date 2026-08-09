module fn_deg2rad
  ! Degrees to radians.
  implicit none

contains

  function calc_deg2rad(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = x * acos(-1.0d0) / 180.0d0
  end function calc_deg2rad

end module fn_deg2rad
