module rot47_keys
  ! Key material helpers for the rot47 cipher.
  implicit none

contains

  function rot47_default_key() result(k)
    integer :: k
    k = 47
  end function rot47_default_key

  function rot47_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rot47_key_valid

end module rot47_keys
