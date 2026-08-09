module zigzag_check
  ! Round-trip verification for the zigzag cipher.
  use zigzag_cipher
  implicit none

contains

  function zigzag_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = zigzag_encrypt(sample)
    dec = zigzag_decrypt(enc)
    ok = all(dec == sample)
  end function zigzag_verify

end module zigzag_check
