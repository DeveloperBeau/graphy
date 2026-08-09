module interleave_keys
  ! Key material helpers for the interleave cipher.
  implicit none

contains

  function interleave_default_key() result(k)
    integer :: k
    k = 8
  end function interleave_default_key

  function interleave_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function interleave_key_valid

end module interleave_keys
