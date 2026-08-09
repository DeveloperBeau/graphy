module affine_cipher
  ! Affine cipher: affine map 5x+8 over bytes.
  implicit none

contains

  function affine_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(5 * data + 8, 256)
  end function affine_encrypt

  function affine_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(205 * (data - 8), 256)
  end function affine_decrypt

end module affine_cipher
