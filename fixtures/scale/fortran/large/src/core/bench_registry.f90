module bench_registry
  implicit none
  integer, parameter :: registry_max = 16
  character(len=16) :: family_names(registry_max)
  integer :: family_count = 0

contains

  subroutine register_family(name)
    character(len=*), intent(in) :: name
    if (family_count >= registry_max) return
    family_count = family_count + 1
    family_names(family_count) = name
  end subroutine register_family

  function registered_count() result(n)
    integer :: n
    n = family_count
  end function registered_count

end module bench_registry
