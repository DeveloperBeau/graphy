module decimation_check
  ! Round-trip verification for the decimation cipher.
  use decimation_cipher
  implicit none

contains

  function decimation_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = decimation_encrypt(sample)
    dec = decimation_decrypt(enc)
    ok = all(dec == sample)
  end function decimation_verify

end module decimation_check
