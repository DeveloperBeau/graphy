module runkey_keys
  ! Key material helpers for the runkey cipher.
  implicit none

contains

  function runkey_default_key() result(k)
    character(len=16) :: k
    k = "THEQUICKBROWNFOX"
  end function runkey_default_key

  function runkey_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function runkey_key_valid

end module runkey_keys
