module autokey_keys
  ! Key material helpers for the autokey cipher.
  implicit none

contains

  function autokey_default_key() result(k)
    character(len=5) :: k
    k = "QUEEN"
  end function autokey_default_key

  function autokey_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function autokey_key_valid

end module autokey_keys
