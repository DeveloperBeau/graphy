module xordigest_keys
  ! Key material helpers for the xordigest cipher.
  implicit none

contains

  function xordigest_default_key() result(k)
    integer :: k
    k = 0
  end function xordigest_default_key

  function xordigest_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function xordigest_key_valid

end module xordigest_keys
