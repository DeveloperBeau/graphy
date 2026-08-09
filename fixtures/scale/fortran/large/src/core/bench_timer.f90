module bench_timer
  implicit none

contains

  function timer_start() result(t0)
    integer :: t0
    call system_clock(t0)
  end function timer_start

  function timer_elapsed_micros(t0) result(us)
    integer, intent(in) :: t0
    integer :: us, t1, rate
    call system_clock(t1, rate)
    us = int(real(t1 - t0) / real(rate) * 1.0e6)
  end function timer_elapsed_micros

end module bench_timer
