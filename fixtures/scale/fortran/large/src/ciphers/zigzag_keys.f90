module zigzag_keys
  ! Key material helpers for the zigzag cipher.
  implicit none

contains

  function zigzag_default_key() result(k)
    integer :: k
    k = 2
  end function zigzag_default_key

  function zigzag_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function zigzag_key_valid

end module zigzag_keys
