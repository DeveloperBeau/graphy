module rc4lite_cipher
  ! Rc4Lite cipher: xor against an LCG key stream (a=181, c=359).
  implicit none
  integer, parameter :: rc4lite_seed = 17

contains

  function rc4lite_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = rc4lite_seed
    do i = 1, n
      state = mod(state * 181 + 359, 65521)
      ks(i) = mod(state, 256)
    end do
  end function rc4lite_keystream

  function rc4lite_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, rc4lite_keystream(size(data)))
  end function rc4lite_encrypt

  function rc4lite_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = rc4lite_encrypt(data)
  end function rc4lite_decrypt

end module rc4lite_cipher
