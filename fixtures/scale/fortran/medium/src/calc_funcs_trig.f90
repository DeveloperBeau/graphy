module calc_funcs_trig
  use fn_sin
  use fn_cos
  use fn_tan
  use fn_asin
  use fn_acos
  use fn_atan
  implicit none

contains

  function dispatch_trig(name, x) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    select case (trim(name))
    case ("sin")
      y = calc_sin(x)
    case ("cos")
      y = calc_cos(x)
    case ("tan")
      y = calc_tan(x)
    case ("asin")
      y = calc_asin(x)
    case ("acos")
      y = calc_acos(x)
    case ("atan")
      y = calc_atan(x)
    case default
      y = x
    end select
  end function dispatch_trig

end module calc_funcs_trig
