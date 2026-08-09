module columnar_check
  ! Round-trip verification for the columnar cipher.
  use columnar_cipher
  implicit none

contains

  function columnar_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = columnar_encrypt(sample)
    dec = columnar_decrypt(enc)
    ok = all(dec == sample)
  end function columnar_verify

end module columnar_check
