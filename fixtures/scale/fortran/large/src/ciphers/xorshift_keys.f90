module xorshift_keys
  ! Key material helpers for the xorshift cipher.
  implicit none

contains

  function xorshift_default_key() result(k)
    integer :: k
    k = 911
  end function xorshift_default_key

  function xorshift_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function xorshift_key_valid

end module xorshift_keys
