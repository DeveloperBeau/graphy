module sdbm_keys
  ! Key material helpers for the sdbm cipher.
  implicit none

contains

  function sdbm_default_key() result(k)
    integer :: k
    k = 0
  end function sdbm_default_key

  function sdbm_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function sdbm_key_valid

end module sdbm_keys
