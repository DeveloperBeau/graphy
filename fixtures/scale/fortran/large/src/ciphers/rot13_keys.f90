module rot13_keys
  ! Key material helpers for the rot13 cipher.
  implicit none

contains

  function rot13_default_key() result(k)
    integer :: k
    k = 13
  end function rot13_default_key

  function rot13_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rot13_key_valid

end module rot13_keys
