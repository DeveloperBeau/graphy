module feistel_cipher
  ! Feistel cipher: xor against an LCG key stream (a=37, c=11).
  implicit none
  integer, parameter :: feistel_seed = 101

contains

  function feistel_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = feistel_seed
    do i = 1, n
      state = mod(state * 37 + 11, 256)
      ks(i) = mod(state, 256)
    end do
  end function feistel_keystream

  function feistel_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, feistel_keystream(size(data)))
  end function feistel_encrypt

  function feistel_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = feistel_encrypt(data)
  end function feistel_decrypt

end module feistel_cipher
