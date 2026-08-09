module fn_log10
  ! Base-10 logarithm.
  implicit none

contains

  function calc_log10(x) result(y)
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    y = log10(x)
  end function calc_log10

end module fn_log10
