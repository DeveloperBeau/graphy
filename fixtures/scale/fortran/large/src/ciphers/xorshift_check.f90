module xorshift_check
  ! Round-trip verification for the xorshift cipher.
  use xorshift_cipher
  implicit none

contains

  function xorshift_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = xorshift_encrypt(sample)
    dec = xorshift_decrypt(enc)
    ok = all(dec == sample)
  end function xorshift_verify

end module xorshift_check
