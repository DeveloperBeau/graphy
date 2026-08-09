module fn_atan
  ! Inverse tangent.
  implicit none

contains

  function calc_atan(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = atan(x)
  end function calc_atan

end module fn_atan
