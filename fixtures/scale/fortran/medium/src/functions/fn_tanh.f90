module fn_tanh
  ! Hyperbolic tangent.
  implicit none

contains

  function calc_tanh(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = tanh(x)
  end function calc_tanh

end module fn_tanh
