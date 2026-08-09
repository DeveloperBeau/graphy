module beaufort_keys
  ! Key material helpers for the beaufort cipher.
  implicit none

contains

  function beaufort_default_key() result(k)
    character(len=8) :: k
    k = "FORTRESS"
  end function beaufort_default_key

  function beaufort_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function beaufort_key_valid

end module beaufort_keys
