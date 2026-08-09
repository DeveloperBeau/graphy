module maskstream_cipher
  ! MaskStream cipher: xor against a fixed 4-byte mask.
  implicit none
  integer, parameter :: maskstream_mask(4) = [23, 105, 187, 7]

contains

  function maskstream_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: i
    do i = 1, n
      ks(i) = maskstream_mask(mod(i - 1, size(maskstream_mask)) + 1)
    end do
  end function maskstream_keystream

  function maskstream_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, maskstream_keystream(size(data)))
  end function maskstream_encrypt

  function maskstream_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = maskstream_encrypt(data)
  end function maskstream_decrypt

end module maskstream_cipher
