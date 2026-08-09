module rot13_check
  ! Round-trip verification for the rot13 cipher.
  use rot13_cipher
  implicit none

contains

  function rot13_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = rot13_encrypt(sample)
    dec = rot13_decrypt(enc)
    ok = all(dec == sample)
  end function rot13_verify

end module rot13_check
