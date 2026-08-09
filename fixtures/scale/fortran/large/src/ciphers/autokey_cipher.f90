module autokey_cipher
  ! Autokey cipher: repeating key "QUEEN" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: autokey_key = "QUEEN"

contains

  function autokey_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(autokey_key)) + 1
    k = iachar(autokey_key(pos:pos))
  end function autokey_key_byte

  function autokey_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + autokey_key_byte(i), 256)
    end do
  end function autokey_encrypt

  function autokey_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - autokey_key_byte(i), 256)
    end do
  end function autokey_decrypt

end module autokey_cipher
