module caesar_check
  ! Round-trip verification for the caesar cipher.
  use caesar_cipher
  implicit none

contains

  function caesar_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = caesar_encrypt(sample)
    dec = caesar_decrypt(enc)
    ok = all(dec == sample)
  end function caesar_verify

end module caesar_check
