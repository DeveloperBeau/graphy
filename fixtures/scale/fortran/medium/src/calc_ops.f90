module calc_ops
  implicit none

contains

  function op_precedence(op) result(prec)
    character(len=*), intent(in) :: op
    integer :: prec
    select case (trim(op))
    case ("+", "-")
      prec = 1
    case ("*", "/")
      prec = 2
    case default
      prec = 0
    end select
  end function op_precedence

  function apply_op(op, a, b) result(value)
    character(len=*), intent(in) :: op
    real(kind=8), intent(in) :: a, b
    real(kind=8) :: value
    select case (trim(op))
    case ("+")
      value = a + b
    case ("-")
      value = a - b
    case ("*")
      value = a * b
    case default
      value = a / b
    end select
  end function apply_op

end module calc_ops
