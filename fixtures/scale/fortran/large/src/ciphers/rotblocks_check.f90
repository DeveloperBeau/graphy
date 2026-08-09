module rotblocks_check
  ! Round-trip verification for the rotblocks cipher.
  use rotblocks_cipher
  implicit none

contains

  function rotblocks_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = rotblocks_encrypt(sample)
    dec = rotblocks_decrypt(enc)
    ok = all(dec == sample)
  end function rotblocks_verify

end module rotblocks_check
