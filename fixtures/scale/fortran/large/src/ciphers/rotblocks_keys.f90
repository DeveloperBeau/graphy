module rotblocks_keys
  ! Key material helpers for the rotblocks cipher.
  implicit none

contains

  function rotblocks_default_key() result(k)
    integer :: k
    k = 6
  end function rotblocks_default_key

  function rotblocks_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rotblocks_key_valid

end module rotblocks_keys
