module bench_summary
  use bench_registry
  implicit none

contains

  subroutine summary_row(name, bytes, time)
    character(len=*), intent(in) :: name, bytes, time
    write(*, '(a14,1x,a10,1x,a10)') name, bytes, time
  end subroutine summary_row

  subroutine summary_print()
    write(*, '(a,i0)') "families run: ", registered_count()
    call summary_row("family", "bytes", "time")
    call summary_row("------", "-----", "----")
  end subroutine summary_print

end module bench_summary
