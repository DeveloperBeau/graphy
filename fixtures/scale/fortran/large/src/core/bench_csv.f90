module bench_csv
  implicit none

contains

  function csv_header() result(row)
    character(len=64) :: row
    row = "label,bytes,micros"
  end function csv_header

  function csv_row(label, bytes, micros) result(row)
    character(len=*), intent(in) :: label
    integer, intent(in) :: bytes, micros
    character(len=64) :: row
    write(row, '(a,",",i0,",",i0)') trim(label), bytes, micros
  end function csv_row

end module bench_csv
