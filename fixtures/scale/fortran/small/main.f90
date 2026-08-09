program textprint
  ! textprint - render styled text blocks in the terminal.
  use tp_config
  use tp_banner
  use tp_list
  use tp_table
  implicit none
  character(len=64) :: command

  command = "help"
  if (command_argument_count() > 0) then
    call get_command_argument(1, command)
  end if

  select case (trim(command))
  case ("banner")
    call cmd_banner("hello")
  case ("list")
    call cmd_list()
  case ("table")
    call cmd_table()
  case default
    print *, "usage: textprint <banner|list|table>"
  end select
end program textprint
