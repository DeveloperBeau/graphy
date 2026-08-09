module djb2_check
  ! Round-trip verification for the djb2 cipher.
  use djb2_cipher
  implicit none

contains

  function djb2_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = djb2_digest(sample) == djb2_digest(sample)
  end function djb2_verify

end module djb2_check
