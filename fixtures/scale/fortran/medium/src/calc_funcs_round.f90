module calc_funcs_round
  use fn_floor
  use fn_ceil
  use fn_round
  use fn_trunc
  use fn_abs
  use fn_sign
  implicit none

contains

  function dispatch_round(name, x) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    select case (trim(name))
    case ("floor")
      y = calc_floor(x)
    case ("ceil")
      y = calc_ceil(x)
    case ("round")
      y = calc_round(x)
    case ("trunc")
      y = calc_trunc(x)
    case ("abs")
      y = calc_abs(x)
    case ("sign")
      y = calc_sign(x)
    case default
      y = x
    end select
  end function dispatch_round

end module calc_funcs_round
