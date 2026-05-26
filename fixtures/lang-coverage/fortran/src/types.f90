! feature: module, derived type (type :: state)
module types
  implicit none

  integer, parameter :: MAX_RETRIES = 3

  type :: state_t
    character(len=32) :: name
    integer :: status
  end type state_t

end module types
