module addmod_check
  ! Round-trip verification for the addmod cipher.
  use addmod_cipher
  implicit none

contains

  function addmod_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = addmod_encrypt(sample)
    dec = addmod_decrypt(enc)
    ok = all(dec == sample)
  end function addmod_verify

end module addmod_check
