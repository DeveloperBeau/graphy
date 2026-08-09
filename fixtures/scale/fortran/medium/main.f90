program calc
  ! calc - floating point expression calculator with a function library.
  use calc_eval
  use calc_format
  use calc_repl
  implicit none
  character(len=128) :: mode, expr

  mode = "help"
  if (command_argument_count() > 0) then
    call get_command_argument(1, mode)
  end if

  select case (trim(mode))
  case ("-e")
    call get_command_argument(2, expr)
    print *, fmt_result(eval_expr(trim(expr)))
  case ("--repl")
    call repl_loop()
  case default
    print *, "usage: calc [-e EXPR] [--repl]"
  end select
end program calc
