module ctrxor_check
  ! Round-trip verification for the ctrxor cipher.
  use ctrxor_cipher
  implicit none

contains

  function ctrxor_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = ctrxor_encrypt(sample)
    dec = ctrxor_decrypt(enc)
    ok = all(dec == sample)
  end function ctrxor_verify

end module ctrxor_check
