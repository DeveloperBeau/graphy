module xorbasic_keys
  ! Key material helpers for the xorbasic cipher.
  implicit none

contains

  function xorbasic_default_key() result(k)
    integer :: k
    k = 90
  end function xorbasic_default_key

  function xorbasic_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function xorbasic_key_valid

end module xorbasic_keys
