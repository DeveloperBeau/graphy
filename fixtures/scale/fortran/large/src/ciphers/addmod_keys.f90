module addmod_keys
  ! Key material helpers for the addmod cipher.
  implicit none

contains

  function addmod_default_key() result(k)
    integer :: k
    k = 17
  end function addmod_default_key

  function addmod_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function addmod_key_valid

end module addmod_keys
