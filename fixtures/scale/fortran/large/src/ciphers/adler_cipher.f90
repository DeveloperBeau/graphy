module adler_cipher
  ! Adler: two-accumulator checksum.
  implicit none
  integer(kind=8), parameter :: adler_mask32 = 4294967295_8

contains

  function adler_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h, a, s
    integer :: i
    a = 1_8
    s = 0_8
    do i = 1, size(data)
      a = mod(a + int(data(i), 8), 65521_8)
      s = mod(s + a, 65521_8)
    end do
    h = ior(ishft(s, 16), a)
  end function adler_digest

  function adler_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') adler_digest(data)
  end function adler_hex

end module adler_cipher
