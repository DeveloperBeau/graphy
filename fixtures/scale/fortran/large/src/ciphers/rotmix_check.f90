module rotmix_check
  ! Round-trip verification for the rotmix cipher.
  use rotmix_cipher
  implicit none

contains

  function rotmix_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = rotmix_encrypt(sample)
    dec = rotmix_decrypt(enc)
    ok = all(dec == sample)
  end function rotmix_verify

end module rotmix_check
