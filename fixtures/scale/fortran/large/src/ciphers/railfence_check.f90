module railfence_check
  ! Round-trip verification for the railfence cipher.
  use railfence_cipher
  implicit none

contains

  function railfence_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = railfence_encrypt(sample)
    dec = railfence_decrypt(enc)
    ok = all(dec == sample)
  end function railfence_verify

end module railfence_check
