module sum32_keys
  ! Key material helpers for the sum32 cipher.
  implicit none

contains

  function sum32_default_key() result(k)
    integer :: k
    k = 0
  end function sum32_default_key

  function sum32_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function sum32_key_valid

end module sum32_keys
