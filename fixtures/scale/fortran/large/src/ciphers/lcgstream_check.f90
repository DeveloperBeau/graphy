module lcgstream_check
  ! Round-trip verification for the lcgstream cipher.
  use lcgstream_cipher
  implicit none

contains

  function lcgstream_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = lcgstream_encrypt(sample)
    dec = lcgstream_decrypt(enc)
    ok = all(dec == sample)
  end function lcgstream_verify

end module lcgstream_check
