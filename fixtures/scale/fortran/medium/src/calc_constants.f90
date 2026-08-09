module calc_constants
  implicit none
  real(kind=8), parameter :: const_pi = acos(-1.0d0)
  real(kind=8), parameter :: const_e = exp(1.0d0)

contains

  function constant_get(name) result(value)
    character(len=*), intent(in) :: name
    real(kind=8) :: value
    select case (trim(name))
    case ("pi")
      value = const_pi
    case ("e")
      value = const_e
    case ("tau")
      value = 2.0d0 * const_pi
    case default
      value = 0.0d0
    end select
  end function constant_get

end module calc_constants
