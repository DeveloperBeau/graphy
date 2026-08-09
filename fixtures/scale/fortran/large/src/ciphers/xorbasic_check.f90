module xorbasic_check
  ! Round-trip verification for the xorbasic cipher.
  use xorbasic_cipher
  implicit none

contains

  function xorbasic_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = xorbasic_encrypt(sample)
    dec = xorbasic_decrypt(enc)
    ok = all(dec == sample)
  end function xorbasic_verify

end module xorbasic_check
