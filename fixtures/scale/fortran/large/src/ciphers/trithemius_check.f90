module trithemius_check
  ! Round-trip verification for the trithemius cipher.
  use trithemius_cipher
  implicit none

contains

  function trithemius_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = trithemius_encrypt(sample)
    dec = trithemius_decrypt(enc)
    ok = all(dec == sample)
  end function trithemius_verify

end module trithemius_check
