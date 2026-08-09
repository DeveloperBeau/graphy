module fn_cube
  ! Third power.
  implicit none

contains

  function calc_cube(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = x * x * x
  end function calc_cube

end module fn_cube
