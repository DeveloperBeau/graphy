module keymix_keys
  ! Key material helpers for the keymix cipher.
  implicit none

contains

  function keymix_default_key() result(k)
    character(len=5) :: k
    k = "ZEBRA"
  end function keymix_default_key

  function keymix_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function keymix_key_valid

end module keymix_keys
