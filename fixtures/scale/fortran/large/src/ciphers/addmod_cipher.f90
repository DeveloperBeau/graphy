module addmod_cipher
  ! Addmod cipher: fixed +17 byte rotation.
  implicit none

contains

  function addmod_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data + 17, 256)
  end function addmod_encrypt

  function addmod_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data - 17, 256)
  end function addmod_decrypt

end module addmod_cipher
