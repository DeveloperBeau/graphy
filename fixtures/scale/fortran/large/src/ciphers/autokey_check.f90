module autokey_check
  ! Round-trip verification for the autokey cipher.
  use autokey_cipher
  implicit none

contains

  function autokey_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = autokey_encrypt(sample)
    dec = autokey_decrypt(enc)
    ok = all(dec == sample)
  end function autokey_verify

end module autokey_check
