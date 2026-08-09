module bench_args
  implicit none
  integer :: bench_rounds = 16
  integer :: bench_sample_size = 512

contains

  subroutine parse_args()
    character(len=16) :: value
    if (command_argument_count() >= 2) then
      call get_command_argument(2, value)
      read(value, *) bench_rounds
    end if
  end subroutine parse_args

  function args_summary() result(text)
    character(len=48) :: text
    write(text, '(a,i0,a,i0)') "rounds=", bench_rounds, " size=", bench_sample_size
  end function args_summary

end module bench_args
