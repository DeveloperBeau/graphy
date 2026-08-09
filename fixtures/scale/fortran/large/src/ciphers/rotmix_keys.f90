module rotmix_keys
  ! Key material helpers for the rotmix cipher.
  implicit none

contains

  function rotmix_default_key() result(k)
    integer :: k
    k = 3
  end function rotmix_default_key

  function rotmix_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rotmix_key_valid

end module rotmix_keys
