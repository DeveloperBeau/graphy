module rothash_cipher
  ! RotHash: rotate-xor digest.
  implicit none
  integer(kind=8), parameter :: rothash_mask32 = 4294967295_8

contains

  function rothash_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 99991_8
    do i = 1, size(data)
      h = iand(ieor(ior(ishft(iand(h, 134217727_8), 5), ishft(h, -27)), int(data(i), 8)), rothash_mask32)
    end do
  end function rothash_digest

  function rothash_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') rothash_digest(data)
  end function rothash_hex

end module rothash_cipher
