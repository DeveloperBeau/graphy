module tp_list
  use tp_log
  implicit none

contains

  function list_item(item) result(bullet)
    character(len=*), intent(in) :: item
    character(len=len(item) + 4) :: bullet
    bullet = "  * " // item
  end function list_item

  subroutine cmd_list()
    call log_info("rendering list")
    print *, list_item("alpha")
    print *, list_item("beta")
    print *, list_item("gamma")
  end subroutine cmd_list

end module tp_list
