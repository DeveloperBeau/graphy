module cbcxor_keys
  ! Key material helpers for the cbcxor cipher.
  implicit none

contains

  function cbcxor_default_key() result(k)
    integer :: k
    k = 113
  end function cbcxor_default_key

  function cbcxor_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function cbcxor_key_valid

end module cbcxor_keys
