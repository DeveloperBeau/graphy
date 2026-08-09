module calc_registry
  implicit none
  integer, parameter :: registry_max = 64
  character(len=16) :: registered_names(registry_max)
  integer :: registered_total = 0

contains

  subroutine registry_add(name)
    character(len=*), intent(in) :: name
    if (registered_total >= registry_max) return
    registered_total = registered_total + 1
    registered_names(registered_total) = name
  end subroutine registry_add

  function registry_size() result(n)
    integer :: n
    n = registered_total
  end function registry_size

end module calc_registry
