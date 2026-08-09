module bench_log
  use iso_fortran_env, only: error_unit
  implicit none

contains

  subroutine log_write(level, message)
    character(len=*), intent(in) :: level, message
    write(error_unit, '(a,a,a,a)') "[", level, "] ", message
  end subroutine log_write

  subroutine log_info(message)
    character(len=*), intent(in) :: message
    call log_write("INFO", message)
  end subroutine log_info

  subroutine log_warn(message)
    character(len=*), intent(in) :: message
    call log_write("WARN", message)
  end subroutine log_warn

end module bench_log
