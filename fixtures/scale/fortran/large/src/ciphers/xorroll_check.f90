module xorroll_check
  ! Round-trip verification for the xorroll cipher.
  use xorroll_cipher
  implicit none

contains

  function xorroll_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = xorroll_encrypt(sample)
    dec = xorroll_decrypt(enc)
    ok = all(dec == sample)
  end function xorroll_verify

end module xorroll_check
