module revblocks_check
  ! Round-trip verification for the revblocks cipher.
  use revblocks_cipher
  implicit none

contains

  function revblocks_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = revblocks_encrypt(sample)
    dec = revblocks_decrypt(enc)
    ok = all(dec == sample)
  end function revblocks_verify

end module revblocks_check
