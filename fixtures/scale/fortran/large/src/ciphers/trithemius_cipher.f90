module trithemius_cipher
  ! Trithemius cipher: repeating key "ABC" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: trithemius_key = "ABC"

contains

  function trithemius_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(trithemius_key)) + 1
    k = iachar(trithemius_key(pos:pos))
  end function trithemius_key_byte

  function trithemius_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + trithemius_key_byte(i) + i - 1, 256)
    end do
  end function trithemius_encrypt

  function trithemius_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - trithemius_key_byte(i) - (i - 1), 256)
    end do
  end function trithemius_decrypt

end module trithemius_cipher
