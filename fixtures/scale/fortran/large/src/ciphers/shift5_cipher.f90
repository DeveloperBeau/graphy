module shift5_cipher
  ! Shift5 cipher: fixed +5 byte rotation.
  implicit none

contains

  function shift5_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data + 5, 256)
  end function shift5_encrypt

  function shift5_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(data - 5, 256)
  end function shift5_decrypt

end module shift5_cipher
