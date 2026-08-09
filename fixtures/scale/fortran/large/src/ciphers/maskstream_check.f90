module maskstream_check
  ! Round-trip verification for the maskstream cipher.
  use maskstream_cipher
  implicit none

contains

  function maskstream_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = maskstream_encrypt(sample)
    dec = maskstream_decrypt(enc)
    ok = all(dec == sample)
  end function maskstream_verify

end module maskstream_check
