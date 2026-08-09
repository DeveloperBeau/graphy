module rot13_cipher
  ! Rot13 cipher: fixed +13 byte rotation.
  implicit none

contains

  function rot13_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data + 13, 256)
  end function rot13_encrypt

  function rot13_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data - 13, 256)
  end function rot13_decrypt

end module rot13_cipher
