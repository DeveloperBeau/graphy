module calc_errors
  implicit none
  character(len=128) :: last_error = ""

contains

  subroutine err_set(message)
    character(len=*), intent(in) :: message
    last_error = message
  end subroutine err_set

  function err_get() result(message)
    character(len=128) :: message
    message = last_error
  end function err_get

  subroutine err_clear()
    last_error = ""
  end subroutine err_clear

end module calc_errors
