module sum32_cipher
  ! Sum32: multiply-accumulate digest (x1).
  implicit none
  integer(kind=8), parameter :: sum32_mask32 = 4294967295_8

contains

  function sum32_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 0_8
    do i = 1, size(data)
      h = iand(h * 1_8 + int(data(i), 8), sum32_mask32)
    end do
  end function sum32_digest

  function sum32_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') sum32_digest(data)
  end function sum32_hex

end module sum32_cipher
