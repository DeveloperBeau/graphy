module caesar_cipher
  ! Caesar cipher: fixed +3 byte rotation.
  implicit none

contains

  function caesar_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data + 3, 256)
  end function caesar_encrypt

  function caesar_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data - 3, 256)
  end function caesar_decrypt

end module caesar_cipher
