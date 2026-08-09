module fnv1a_cipher
  ! Fnv1a: xor-then-multiply digest.
  implicit none
  integer(kind=8), parameter :: fnv1a_mask32 = 4294967295_8

contains

  function fnv1a_digest(data) result(h)
    integer, intent(in) :: data(:)
    integer(kind=8) :: h
    integer :: i
    h = 2166136261_8
    do i = 1, size(data)
      h = iand(ieor(h, int(data(i), 8)) * 16777619_8, fnv1a_mask32)
    end do
  end function fnv1a_digest

  function fnv1a_hex(data) result(hex)
    integer, intent(in) :: data(:)
    character(len=8) :: hex
    write(hex, '(z8.8)') fnv1a_digest(data)
  end function fnv1a_hex

end module fnv1a_cipher
