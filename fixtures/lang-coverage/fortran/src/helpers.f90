! feature: module, subroutine, function
module helpers
  implicit none

contains

  subroutine format_name(name, result)
    character(len=*), intent(in) :: name
    character(len=:), allocatable, intent(out) :: result
    result = "hi, " // trim(name)
  end subroutine format_name

  function unrelated_helper() result(r)
    integer :: r
    r = 7
  end function unrelated_helper

end module helpers
