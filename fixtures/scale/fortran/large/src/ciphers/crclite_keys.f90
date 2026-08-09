module crclite_keys
  ! Key material helpers for the crclite cipher.
  implicit none

contains

  function crclite_default_key() result(k)
    integer :: k
    k = 65535
  end function crclite_default_key

  function crclite_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function crclite_key_valid

end module crclite_keys
