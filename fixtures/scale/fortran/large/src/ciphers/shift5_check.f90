module shift5_check
  ! Round-trip verification for the shift5 cipher.
  use shift5_cipher
  implicit none

contains

  function shift5_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = shift5_encrypt(sample)
    dec = shift5_decrypt(enc)
    ok = all(dec == sample)
  end function shift5_verify

end module shift5_check
