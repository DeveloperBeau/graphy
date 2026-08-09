module calc_funcs_shape
  use fn_sqrt
  use fn_square
  use fn_cube
  use fn_reciprocal
  use fn_deg2rad
  use fn_rad2deg
  implicit none

contains

  function dispatch_shape(name, x) result(y)
    character(len=*), intent(in) :: name
    real(kind=8), intent(in) :: x
    real(kind=8) :: y
    select case (trim(name))
    case ("sqrt")
      y = calc_sqrt(x)
    case ("square")
      y = calc_square(x)
    case ("cube")
      y = calc_cube(x)
    case ("reciprocal")
      y = calc_reciprocal(x)
    case ("deg2rad")
      y = calc_deg2rad(x)
    case ("rad2deg")
      y = calc_rad2deg(x)
    case default
      y = x
    end select
  end function dispatch_shape

end module calc_funcs_shape
