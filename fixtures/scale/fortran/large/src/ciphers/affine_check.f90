module affine_check
  ! Round-trip verification for the affine cipher.
  use affine_cipher
  implicit none

contains

  function affine_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = affine_encrypt(sample)
    dec = affine_decrypt(enc)
    ok = all(dec == sample)
  end function affine_verify

end module affine_check
