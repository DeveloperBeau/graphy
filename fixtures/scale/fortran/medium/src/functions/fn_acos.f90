module fn_acos
  ! Inverse cosine.
  implicit none

contains

  function calc_acos(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = acos(x)
  end function calc_acos

end module fn_acos
