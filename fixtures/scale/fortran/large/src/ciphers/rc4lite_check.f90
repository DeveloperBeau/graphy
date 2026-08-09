module rc4lite_check
  ! Round-trip verification for the rc4lite cipher.
  use rc4lite_cipher
  implicit none

contains

  function rc4lite_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = rc4lite_encrypt(sample)
    dec = rc4lite_decrypt(enc)
    ok = all(dec == sample)
  end function rc4lite_verify

end module rc4lite_check
