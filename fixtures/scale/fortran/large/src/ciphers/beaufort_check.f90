module beaufort_check
  ! Round-trip verification for the beaufort cipher.
  use beaufort_cipher
  implicit none

contains

  function beaufort_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = beaufort_encrypt(sample)
    dec = beaufort_decrypt(enc)
    ok = all(dec == sample)
  end function beaufort_verify

end module beaufort_check
