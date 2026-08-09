module ctrxor_keys
  ! Key material helpers for the ctrxor cipher.
  implicit none

contains

  function ctrxor_default_key() result(k)
    integer :: k
    k = 7
  end function ctrxor_default_key

  function ctrxor_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function ctrxor_key_valid

end module ctrxor_keys
