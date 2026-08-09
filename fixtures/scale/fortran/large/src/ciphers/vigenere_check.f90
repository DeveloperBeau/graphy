module vigenere_check
  ! Round-trip verification for the vigenere cipher.
  use vigenere_cipher
  implicit none

contains

  function vigenere_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = vigenere_encrypt(sample)
    dec = vigenere_decrypt(enc)
    ok = all(dec == sample)
  end function vigenere_verify

end module vigenere_check
