module keymix_check
  ! Round-trip verification for the keymix cipher.
  use keymix_cipher
  implicit none

contains

  function keymix_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = keymix_encrypt(sample)
    dec = keymix_decrypt(enc)
    ok = all(dec == sample)
  end function keymix_verify

end module keymix_check
