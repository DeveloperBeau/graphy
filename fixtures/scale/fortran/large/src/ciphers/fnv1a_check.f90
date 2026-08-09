module fnv1a_check
  ! Round-trip verification for the fnv1a cipher.
  use fnv1a_cipher
  implicit none

contains

  function fnv1a_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = fnv1a_digest(sample) == fnv1a_digest(sample)
  end function fnv1a_verify

end module fnv1a_check
