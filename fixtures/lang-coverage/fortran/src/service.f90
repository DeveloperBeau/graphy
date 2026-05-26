! feature: module, use, subroutine, function, call
module service
  use types
  use helpers
  implicit none

contains

  subroutine run_service(name)
    character(len=*), intent(in) :: name
    character(len=:), allocatable :: greeting
    call format_name(name, greeting)
    print *, greeting
  end subroutine run_service

  function make_state(name) result(s)
    character(len=*), intent(in) :: name
    type(state_t) :: s
    s%name = name
    s%status = 0
  end function make_state

end module service
