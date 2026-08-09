module lcgstream_keys
  ! Key material helpers for the lcgstream cipher.
  implicit none

contains

  function lcgstream_default_key() result(k)
    integer :: k
    k = 42
  end function lcgstream_default_key

  function lcgstream_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function lcgstream_key_valid

end module lcgstream_keys
