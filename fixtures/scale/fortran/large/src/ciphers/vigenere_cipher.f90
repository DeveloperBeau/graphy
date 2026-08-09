module vigenere_cipher
  ! Vigenere cipher: repeating key "LEMON" mixed into the byte stream.
  implicit none
  character(len=*), parameter :: vigenere_key = "LEMON"

contains

  function vigenere_key_byte(i) result(k)
    integer, intent(in) :: i
    integer :: k, pos
    pos = mod(i - 1, len(vigenere_key)) + 1
    k = iachar(vigenere_key(pos:pos))
  end function vigenere_key_byte

  function vigenere_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) + vigenere_key_byte(i), 256)
    end do
  end function vigenere_encrypt

  function vigenere_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    integer :: i
    do i = 1, size(data)
      out(i) = modulo(data(i) - vigenere_key_byte(i), 256)
    end do
  end function vigenere_decrypt

end module vigenere_cipher
