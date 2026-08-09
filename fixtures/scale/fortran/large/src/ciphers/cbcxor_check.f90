module cbcxor_check
  ! Round-trip verification for the cbcxor cipher.
  use cbcxor_cipher
  implicit none

contains

  function cbcxor_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = cbcxor_encrypt(sample)
    dec = cbcxor_decrypt(enc)
    ok = all(dec == sample)
  end function cbcxor_verify

end module cbcxor_check
