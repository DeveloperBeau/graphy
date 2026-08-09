module interleave_check
  ! Round-trip verification for the interleave cipher.
  use interleave_cipher
  implicit none

contains

  function interleave_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = interleave_encrypt(sample)
    dec = interleave_decrypt(enc)
    ok = all(dec == sample)
  end function interleave_verify

end module interleave_check
