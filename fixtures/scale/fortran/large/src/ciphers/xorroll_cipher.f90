module xorroll_cipher
  ! XorRoll cipher: xor against an LCG key stream (a=75, c=74).
  implicit none
  integer, parameter :: xorroll_seed = 193

contains

  function xorroll_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = xorroll_seed
    do i = 1, n
      state = mod(state * 75 + 74, 65537)
      ks(i) = mod(state, 256)
    end do
  end function xorroll_keystream

  function xorroll_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, xorroll_keystream(size(data)))
  end function xorroll_encrypt

  function xorroll_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = xorroll_encrypt(data)
  end function xorroll_decrypt

end module xorroll_cipher
