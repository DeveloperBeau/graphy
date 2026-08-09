module xorshift_cipher
  ! XorShift cipher: xor against a 16-bit xorshift key stream.
  implicit none
  integer, parameter :: xorshift_seed = 911

contains

  function xorshift_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = xorshift_seed
    do i = 1, n
      state = iand(ieor(state, ishft(state, 3)), 65535)
      state = iand(ieor(state, ishft(state, -5)), 65535)
      ks(i) = mod(state, 256)
    end do
  end function xorshift_keystream

  function xorshift_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, xorshift_keystream(size(data)))
  end function xorshift_encrypt

  function xorshift_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = xorshift_encrypt(data)
  end function xorshift_decrypt

end module xorshift_cipher
