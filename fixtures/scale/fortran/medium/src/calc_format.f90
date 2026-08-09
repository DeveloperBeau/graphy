module calc_format
  use calc_config
  implicit none

contains

  function fmt_number(value) result(text)
    real(kind=8), intent(in) :: value
    character(len=32) :: text
    write(text, '(f0.6)') value
  end function fmt_number

  function fmt_result(value) result(text)
    real(kind=8), intent(in) :: value
    character(len=34) :: text
    text = "= " // fmt_number(value)
  end function fmt_result

end module calc_format
