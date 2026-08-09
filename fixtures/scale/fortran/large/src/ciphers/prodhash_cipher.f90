module prodhash_cipher
  ! ProdHash: multiply-accumulate digest (x31).
  implicit none
  integer(kind=8), parameter :: prodhash_mask32 = 4294967295_8

contains

  function prodhash_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 7_8
    do i = 1, size(data)
      h = iand(h * 31_8 + int(data(i), 8), prodhash_mask32)
    end do
  end function prodhash_digest

  function prodhash_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') prodhash_digest(data)
  end function prodhash_hex

end module prodhash_cipher
