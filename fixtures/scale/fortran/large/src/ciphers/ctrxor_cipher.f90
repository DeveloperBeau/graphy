module ctrxor_cipher
  ! CtrXor cipher: xor against an LCG key stream (a=1, c=1).
  implicit none
  integer, parameter :: ctrxor_seed = 7

contains

  function ctrxor_keystream(n) result(ks)
    integer, intent(in) :: n
    integer :: ks(n)
    integer :: state, i
    state = ctrxor_seed
    do i = 1, n
      state = mod(state * 1 + 1, 256)
      ks(i) = mod(state, 256)
    end do
  end function ctrxor_keystream

  function ctrxor_encrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    out = ieor(data, ctrxor_keystream(size(data)))
  end function ctrxor_encrypt

  function ctrxor_decrypt(data) result(out)
    integer, intent(in) :: data(:)
    integer :: out(size(data))
    ! Xor stream ciphers are symmetric.
    out = ctrxor_encrypt(data)
  end function ctrxor_decrypt

end module ctrxor_cipher
