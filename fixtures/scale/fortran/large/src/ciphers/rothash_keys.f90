module rothash_keys
  ! Key material helpers for the rothash cipher.
  implicit none

contains

  function rothash_default_key() result(k)
    integer :: k
    k = 34455
  end function rothash_default_key

  function rothash_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rothash_key_valid

end module rothash_keys
