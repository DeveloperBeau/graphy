module fn_logbase
  ! Logarithm in an arbitrary base.
  implicit none

contains

  function calc_logbase(a, b) result(y)
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    y = log(a) / log(b)
  end function calc_logbase

end module fn_logbase
