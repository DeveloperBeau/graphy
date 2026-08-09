module djb2_cipher
  ! Djb2: multiply-accumulate digest (x33).
  implicit none
  integer(kind=8), parameter :: djb2_mask32 = 4294967295_8

contains

  function djb2_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 5381_8
    do i = 1, size(data)
      h = iand(h * 33_8 + int(data(i), 8), djb2_mask32)
    end do
  end function djb2_digest

  function djb2_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') djb2_digest(data)
  end function djb2_hex

end module djb2_cipher
