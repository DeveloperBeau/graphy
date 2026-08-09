module fn_cosh
  ! Hyperbolic cosine.
  implicit none

contains

  function calc_cosh(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = cosh(x)
  end function calc_cosh

end module fn_cosh
