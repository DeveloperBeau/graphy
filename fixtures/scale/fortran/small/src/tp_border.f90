module tp_border
  implicit none

contains

  function border_rule(width) result(rule)
    integer, intent(in) :: width
    character(len=width + 2) :: rule
    rule = "+" // repeat("-", width) // "+"
  end function border_rule

  subroutine border_print(line, width)
    character(len=*), intent(in) :: line
    integer, intent(in) :: width
    print *, border_rule(width)
    print *, "|" // line // "|"
    print *, border_rule(width)
  end subroutine border_print

end module tp_border
