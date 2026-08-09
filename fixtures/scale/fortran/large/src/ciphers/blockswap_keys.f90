module blockswap_keys
  ! Key material helpers for the blockswap cipher.
  implicit none

contains

  function blockswap_default_key() result(k)
    integer :: k
    k = 8
  end function blockswap_default_key

  function blockswap_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function blockswap_key_valid

end module blockswap_keys
