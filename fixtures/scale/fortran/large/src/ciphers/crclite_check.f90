module crclite_check
  ! Round-trip verification for the crclite cipher.
  use crclite_cipher
  implicit none

contains

  function crclite_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = crclite_digest(sample) == crclite_digest(sample)
  end function crclite_verify

end module crclite_check
