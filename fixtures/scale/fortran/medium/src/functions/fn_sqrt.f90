module fn_sqrt
  ! Square root.
  implicit none

contains

  function calc_sqrt(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = sqrt(x)
  end function calc_sqrt

end module fn_sqrt
