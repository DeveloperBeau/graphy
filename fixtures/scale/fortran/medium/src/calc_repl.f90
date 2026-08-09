module calc_repl
  use calc_eval
  use calc_history
  use calc_format
  implicit none

contains

  subroutine repl_loop()
    character(len=128) :: line
    integer :: ios
    real(kind=8) :: value
    do
      write(*, '(a)', advance='no') "calc> "
      read(*, '(a)', iostat=ios) line
      if (ios /= 0) exit
      if (trim(line) == "quit") exit
      value = eval_expr(trim(line))
      call history_add(trim(line), value)
      print *, fmt_result(value)
    end do
  end subroutine repl_loop

end module calc_repl
