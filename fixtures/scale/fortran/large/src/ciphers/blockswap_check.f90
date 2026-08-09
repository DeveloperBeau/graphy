module blockswap_check
  ! Round-trip verification for the blockswap cipher.
  use blockswap_cipher
  implicit none

contains

  function blockswap_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    integer :: enc(size(sample)), dec(size(sample))
    enc = blockswap_encrypt(sample)
    dec = blockswap_decrypt(enc)
    ok = all(dec == sample)
  end function blockswap_verify

end module blockswap_check
