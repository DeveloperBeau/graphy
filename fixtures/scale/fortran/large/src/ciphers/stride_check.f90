module stride_check
  ! Round-trip verification for the stride cipher.
  use stride_cipher
  implicit none

contains

  function stride_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = stride_encrypt(sample)
    dec = stride_decrypt(enc)
    ok = all(dec == sample)
  end function stride_verify

end module stride_check
