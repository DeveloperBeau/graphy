module feistel_check
  ! Round-trip verification for the feistel cipher.
  use feistel_cipher
  implicit none

contains

  function feistel_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = feistel_encrypt(sample)
    dec = feistel_decrypt(enc)
    ok = all(dec == sample)
  end function feistel_verify

end module feistel_check
