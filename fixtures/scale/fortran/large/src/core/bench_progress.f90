module bench_progress
  implicit none
  integer :: progress_total = 0
  integer :: ticks_done = 0

contains

  subroutine progress_start(total)
    integer, intent(in) :: total
    progress_total = total
    ticks_done = 0
  end subroutine progress_start

  subroutine progress_tick(label)
    character(len=*), intent(in) :: label
    ticks_done = ticks_done + 1
    write(*, '(a,i0,a,i0,a,a)', advance='no') &
      char(13) // "[", ticks_done, "/", progress_total, "] ", label
  end subroutine progress_tick

  subroutine progress_finish()
    write(*, '(a)') ""
  end subroutine progress_finish

end module bench_progress
