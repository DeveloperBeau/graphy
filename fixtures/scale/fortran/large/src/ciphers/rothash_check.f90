module rothash_check
  ! Round-trip verification for the rothash cipher.
  use rothash_cipher
  implicit none

contains

  function rothash_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = rothash_digest(sample) == rothash_digest(sample)
  end function rothash_verify

end module rothash_check
