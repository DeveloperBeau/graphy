module tp_colors
  implicit none

contains

  function color_code(name) result(code)
    character(len=*), intent(in) :: name
    integer :: code
    select case (trim(name))
    case ("red")
      code = 31
    case ("green")
      code = 32
    case ("cyan")
      code = 36
    case default
      code = 0
    end select
  end function color_code

  function colorize(name, text) result(colored)
    character(len=*), intent(in) :: name, text
    character(len=len(text) + 16) :: colored
    character(len=2) :: code
    write(code, '(i2)') color_code(name)
    colored = char(27) // "[" // trim(adjustl(code)) // "m" // text // char(27) // "[0m"
  end function colorize

end module tp_colors
