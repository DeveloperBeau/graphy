module fn_cos
  ! Cosine.
  implicit none

contains

  function calc_cos(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = cos(x)
  end function calc_cos

end module fn_cos
