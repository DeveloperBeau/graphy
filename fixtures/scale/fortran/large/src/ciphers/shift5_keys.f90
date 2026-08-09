module shift5_keys
  ! Key material helpers for the shift5 cipher.
  implicit none

contains

  function shift5_default_key() result(k)
    integer :: k
    k = 5
  end function shift5_default_key

  function shift5_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function shift5_key_valid

end module shift5_keys
