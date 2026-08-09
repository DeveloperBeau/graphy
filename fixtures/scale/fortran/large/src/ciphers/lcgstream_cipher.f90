module lcgstream_cipher
  ! LcgStream cipher: xor against an LCG key stream (a=1229, c=17).
  implicit none
  integer, parameter :: lcgstream_seed = 42

contains

  function lcgstream_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = lcgstream_seed
    do i = 1, n
      state = mod(state * 1229 + 17, 32749)
      ks(i) = mod(state, 256)
    end do
  end function lcgstream_keystream

  function lcgstream_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, lcgstream_keystream(size(data)))
  end function lcgstream_encrypt

  function lcgstream_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = lcgstream_encrypt(data)
  end function lcgstream_decrypt

end module lcgstream_cipher
