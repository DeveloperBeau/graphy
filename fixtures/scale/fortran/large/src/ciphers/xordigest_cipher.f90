module xordigest_cipher
  ! XorDigest: position-spread xor digest.
  implicit none
  integer(kind=8), parameter :: xordigest_mask32 = 4294967295_8

contains

  function xordigest_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 0_8
    do i = 1, size(data)
      h = iand(ieor(h, ishft(int(data(i), 8), mod(i - 1, 4) * 8)), xordigest_mask32)
    end do
  end function xordigest_digest

  function xordigest_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') xordigest_digest(data)
  end function xordigest_hex

end module xordigest_cipher
