module xordigest_check
  ! Round-trip verification for the xordigest cipher.
  use xordigest_cipher
  implicit none

contains

  function xordigest_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = xordigest_digest(sample) == xordigest_digest(sample)
  end function xordigest_verify

end module xordigest_check
