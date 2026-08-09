module calc_config
  implicit none
  integer :: precision_digits = 6
  character(len=8) :: angle_unit = "radians"

contains

  function config_precision() result(digits)
    integer :: digits
    digits = precision_digits
  end function config_precision

  subroutine config_set_precision(digits)
    integer, intent(in) :: digits
    precision_digits = digits
  end subroutine config_set_precision

end module calc_config
