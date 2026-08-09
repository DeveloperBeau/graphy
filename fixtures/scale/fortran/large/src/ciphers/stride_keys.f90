module stride_keys
  ! Key material helpers for the stride cipher.
  implicit none

contains

  function stride_default_key() result(k)
    integer :: k
    k = 9
  end function stride_default_key

  function stride_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function stride_key_valid

end module stride_keys
