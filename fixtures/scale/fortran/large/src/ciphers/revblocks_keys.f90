module revblocks_keys
  ! Key material helpers for the revblocks cipher.
  implicit none

contains

  function revblocks_default_key() result(k)
    integer :: k
    k = 4
  end function revblocks_default_key

  function revblocks_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function revblocks_key_valid

end module revblocks_keys
