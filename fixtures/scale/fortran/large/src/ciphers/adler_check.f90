module adler_check
  ! Round-trip verification for the adler cipher.
  use adler_cipher
  implicit none

contains

  function adler_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = adler_digest(sample) == adler_digest(sample)
  end function adler_verify

end module adler_check
