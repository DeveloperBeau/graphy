module calc_funcs_binary
  use fn_power
  use fn_hypot
  use fn_logbase
  use fn_atan2c
  use fn_modc
  use fn_gcd
  use fn_fibonacci
  implicit none

contains

  function dispatch_binary(name, a, b) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: y
    select case (trim(name))
    case ("power")
      y = calc_power(a, b)
    case ("hypot")
      y = calc_hypot(a, b)
    case ("logbase")
      y = calc_logbase(a, b)
    case ("atan2c")
      y = calc_atan2c(a, b)
    case ("modc")
      y = calc_modc(a, b)
    case ("gcd")
      y = real(calc_gcd(int(a), int(b)), kind=8)
    case ("fib")
      y = real(calc_fibonacci(int(a)), kind=8)
    case default
      y = a
    end select
  end function dispatch_binary

end module calc_funcs_binary
