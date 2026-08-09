module fn_sin
  ! Sine.
  implicit none

contains

  function calc_sin(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = sin(x)
  end function calc_sin

end module fn_sin
