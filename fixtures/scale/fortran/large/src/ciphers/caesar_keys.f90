module caesar_keys
  ! Key material helpers for the caesar cipher.
  implicit none

contains

  function caesar_default_key() result(k)
    integer :: k
    k = 3
  end function caesar_default_key

  function caesar_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function caesar_key_valid

end module caesar_keys
