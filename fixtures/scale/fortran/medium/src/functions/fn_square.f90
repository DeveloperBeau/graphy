module fn_square
  ! Second power.
  implicit none

contains

  function calc_square(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = x * x
  end function calc_square

end module fn_square
