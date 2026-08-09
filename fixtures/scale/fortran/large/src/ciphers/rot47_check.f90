module rot47_check
  ! Round-trip verification for the rot47 cipher.
  use rot47_cipher
  implicit none

contains

  function rot47_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = rot47_encrypt(sample)
    dec = rot47_decrypt(enc)
    ok = all(dec == sample)
  end function rot47_verify

end module rot47_check
