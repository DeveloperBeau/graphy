module porta_keys
  ! Key material helpers for the porta cipher.
  implicit none

contains

  function porta_default_key() result(k)
    character(len=7) :: k
    k = "GLACIER"
  end function porta_default_key

  function porta_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function porta_key_valid

end module porta_keys
