module decimation_cipher
  ! Decimation cipher: affine map 7x+0 over bytes.
  implicit none

contains

  function decimation_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(7 * data + 0, 256)
  end function decimation_encrypt

  function decimation_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = modulo(183 * (data - 0), 256)
  end function decimation_decrypt

end module decimation_cipher
