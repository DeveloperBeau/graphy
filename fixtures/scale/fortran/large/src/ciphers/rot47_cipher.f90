module rot47_cipher
  ! Rot47 cipher: fixed +47 byte rotation.
  implicit none

contains

  function rot47_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data + 47, 256)
  end function rot47_encrypt

  function rot47_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data - 47, 256)
  end function rot47_decrypt

end module rot47_cipher
