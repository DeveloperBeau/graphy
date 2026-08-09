module bench_format
  implicit none

contains

  function fmt_bytes(n) result(text)
    integer, intent(in) :: n
    character(len=16) :: text
    if (n >= 1048576) then
      write(text, '(i0,a)') n / 1048576, "MiB"
    else if (n >= 1024) then
      write(text, '(i0,a)') n / 1024, "KiB"
    else
      write(text, '(i0,a)') n, "B"
    end if
  end function fmt_bytes

  function fmt_micros(us) result(text)
    integer, intent(in) :: us
    character(len=16) :: text
    if (us >= 1000000) then
      write(text, '(i0,a)') us / 1000000, "s"
    else
      write(text, '(i0,a)') us, "us"
    end if
  end function fmt_micros

end module bench_format
