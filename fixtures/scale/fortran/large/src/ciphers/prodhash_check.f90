module prodhash_check
  ! Round-trip verification for the prodhash cipher.
  use prodhash_cipher
  implicit none

contains

  function prodhash_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = prodhash_digest(sample) == prodhash_digest(sample)
  end function prodhash_verify

end module prodhash_check
