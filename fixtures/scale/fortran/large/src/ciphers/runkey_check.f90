module runkey_check
  ! Round-trip verification for the runkey cipher.
  use runkey_cipher
  implicit none

contains

  function runkey_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = runkey_encrypt(sample)
    dec = runkey_decrypt(enc)
    ok = all(dec == sample)
  end function runkey_verify

end module runkey_check
