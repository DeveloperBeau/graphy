module scytale_keys
  ! Key material helpers for the scytale cipher.
  implicit none

contains

  function scytale_default_key() result(k)
    integer :: k
    k = 6
  end function scytale_default_key

  function scytale_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function scytale_key_valid

end module scytale_keys
