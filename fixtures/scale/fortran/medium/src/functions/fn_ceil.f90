module fn_ceil
  ! Round toward positive infinity.
  implicit none

contains

  function calc_ceil(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = real(ceiling(x), kind=8)
  end function calc_ceil

end module fn_ceil
