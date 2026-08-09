module fn_round
  ! Round to nearest.
  implicit none

contains

  function calc_round(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = real(nint(x), kind=8)
  end function calc_round

end module fn_round
