module xorbasic_cipher
  ! XorBasic cipher: xor against a fixed 1-byte mask.
  implicit none
  integer, parameter :: xorbasic_mask(1) = [90]

contains

  function xorbasic_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: i
    do i = 1, n
      ks(i) = xorbasic_mask(mod(i - 1, size(xorbasic_mask)) + 1)
    end do
  end function xorbasic_keystream

  function xorbasic_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, xorbasic_keystream(size(data)))
  end function xorbasic_encrypt

  function xorbasic_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = xorbasic_encrypt(data)
  end function xorbasic_decrypt

end module xorbasic_cipher
