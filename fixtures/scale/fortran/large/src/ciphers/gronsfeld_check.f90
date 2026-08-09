module gronsfeld_check
  ! Round-trip verification for the gronsfeld cipher.
  use gronsfeld_cipher
  implicit none

contains

  function gronsfeld_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = gronsfeld_encrypt(sample)
    dec = gronsfeld_decrypt(enc)
    ok = all(dec == sample)
  end function gronsfeld_verify

end module gronsfeld_check
