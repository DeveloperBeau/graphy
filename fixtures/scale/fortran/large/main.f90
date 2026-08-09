program ciphbench
  ! ciphbench - throughput and round-trip checks for toy ciphers.
  use bench_args
  use bench_run
  use bench_verify
  use bench_report
  implicit none
  character(len=32) :: command

  command = "help"
  if (command_argument_count() > 0) then
    call get_command_argument(1, command)
  end if
  call parse_args()

  select case (trim(command))
  case ("run")
    call bench_all()
  case ("report")
    call report_summary()
  case ("verify")
    call verify_all()
  case default
    print *, "usage: ciphbench <run|report|verify>"
  end select
end program ciphbench
