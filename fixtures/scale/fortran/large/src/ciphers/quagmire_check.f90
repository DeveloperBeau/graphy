module quagmire_check
  ! Round-trip verification for the quagmire cipher.
  use quagmire_cipher
  implicit none

contains

  function quagmire_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = quagmire_encrypt(sample)
    dec = quagmire_decrypt(enc)
    ok = all(dec == sample)
  end function quagmire_verify

end module quagmire_check
