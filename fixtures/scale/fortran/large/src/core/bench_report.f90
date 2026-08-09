module bench_report
  use bench_store
  use bench_log
  implicit none

contains

  subroutine report_summary()
    character(len=128) :: row
    integer :: unit, ios
    open(newunit=unit, file=results_path, status="old", action="read", iostat=ios)
    if (ios /= 0) then
      call log_warn("no results file")
      return
    end if
    do
      read(unit, '(a)', iostat=ios) row
      if (ios /= 0) exit
      print *, "  ", trim(row)
    end do
    close(unit)
  end subroutine report_summary

end module bench_report
