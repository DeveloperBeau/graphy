module fn_hypot
  ! Euclidean distance from the origin.
  implicit none

contains

  function calc_hypot(a, b) result(y)
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    y = sqrt(a * a + b * b)
  end function calc_hypot

end module fn_hypot
