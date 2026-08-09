module xorroll_keys
  ! Key material helpers for the xorroll cipher.
  implicit none

contains

  function xorroll_default_key() result(k)
    integer :: k
    k = 193
  end function xorroll_default_key

  function xorroll_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function xorroll_key_valid

end module xorroll_keys
