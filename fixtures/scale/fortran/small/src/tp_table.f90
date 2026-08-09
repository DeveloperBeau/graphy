module tp_table
  use tp_align
  use tp_log
  implicit none

contains

  function table_row(key, value) result(row)
    character(len=*), intent(in) :: key, value
    character(len=32) :: row
    row = pad_left(key, 14) // " " // value
  end function table_row

  subroutine cmd_table()
    call log_info("rendering table")
    print *, repeat("-", 31)
    print *, table_row("name", "textprint")
    print *, table_row("layout", "table")
    print *, repeat("-", 31)
  end subroutine cmd_table

end module tp_table
