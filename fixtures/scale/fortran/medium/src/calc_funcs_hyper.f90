module calc_funcs_hyper
  use fn_sinh
  use fn_cosh
  use fn_tanh
  use fn_exp
  use fn_ln
  use fn_log10
  implicit none

contains

  function dispatch_hyper(name, x) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    select case (trim(name))
    case ("sinh")
      y = calc_sinh(x)
    case ("cosh")
      y = calc_cosh(x)
    case ("tanh")
      y = calc_tanh(x)
    case ("exp")
      y = calc_exp(x)
    case ("ln")
      y = calc_ln(x)
    case ("log10")
      y = calc_log10(x)
    case default
      y = x
    end select
  end function dispatch_hyper

end module calc_funcs_hyper
