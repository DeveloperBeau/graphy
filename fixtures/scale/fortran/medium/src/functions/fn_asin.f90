module fn_asin
  ! Inverse sine.
  implicit none

contains

  function calc_asin(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = asin(x)
  end function calc_asin

end module fn_asin
