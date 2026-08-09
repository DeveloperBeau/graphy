module sdbm_cipher
  ! Sdbm: multiply-accumulate digest (x65599).
  implicit none
  integer(kind=8), parameter :: sdbm_mask32 = 4294967295_8

contains

  function sdbm_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 0_8
    do i = 1, size(data)
      h = iand(h * 65599_8 + int(data(i), 8), sdbm_mask32)
    end do
  end function sdbm_digest

  function sdbm_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') sdbm_digest(data)
  end function sdbm_hex

end module sdbm_cipher
