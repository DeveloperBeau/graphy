module bench_config
  implicit none

contains

  function config_warmup() result(warmup)
    integer :: warmup
    character(len=8) :: override
    call get_environment_variable("CIPHBENCH_WARMUP", override)
    if (len_trim(override) > 0) then
      read(override, *) warmup
    else
      warmup = 2
    end if
  end function config_warmup

  function config_verbose() result(verbose)
    logical :: verbose
    character(len=8) :: override
    call get_environment_variable("CIPHBENCH_VERBOSE", override)
    verbose = trim(override) == "1"
  end function config_verbose

end module bench_config
