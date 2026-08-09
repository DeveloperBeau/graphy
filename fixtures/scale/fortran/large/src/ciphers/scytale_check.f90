module scytale_check
  ! Round-trip verification for the scytale cipher.
  use scytale_cipher
  implicit none

contains

  function scytale_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = scytale_encrypt(sample)
    dec = scytale_decrypt(enc)
    ok = all(dec == sample)
  end function scytale_verify

end module scytale_check
