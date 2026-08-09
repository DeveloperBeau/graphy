module atbash_check
  ! Round-trip verification for the atbash cipher.
  use atbash_cipher
  implicit none

contains

  function atbash_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = atbash_encrypt(sample)
    dec = atbash_decrypt(enc)
    ok = all(dec == sample)
  end function atbash_verify

end module atbash_check
