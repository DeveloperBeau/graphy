module crclite_cipher
  ! CrcLite: shift-xor checksum.
  implicit none
  integer(kind=8), parameter :: crclite_mask32 = 4294967295_8

contains

  function crclite_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = crclite_mask32
    do i = 1, size(data)
      h = iand(ieor(ieor(ishft(h, -1), iand(h, 1_8) * 3988292384_8), int(data(i), 8)), crclite_mask32)
    end do
  end function crclite_digest

  function crclite_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') crclite_digest(data)
  end function crclite_hex

end module crclite_cipher
