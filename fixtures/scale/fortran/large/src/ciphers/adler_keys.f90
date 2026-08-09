module adler_keys
  ! Key material helpers for the adler cipher.
  implicit none

contains

  function adler_default_key() result(k)
    integer :: k
    k = 0
  end function adler_default_key

  function adler_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function adler_key_valid

end module adler_keys
