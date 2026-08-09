module fn_floor
  ! Round toward negative infinity.
  implicit none

contains

  function calc_floor(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = real(floor(x), kind=8)
  end function calc_floor

end module fn_floor
