module porta_check
  ! Round-trip verification for the porta cipher.
  use porta_cipher
  implicit none

contains

  function porta_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = porta_encrypt(sample)
    dec = porta_decrypt(enc)
    ok = all(dec == sample)
  end function porta_verify

end module porta_check
