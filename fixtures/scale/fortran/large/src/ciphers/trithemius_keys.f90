module trithemius_keys
  ! Key material helpers for the trithemius cipher.
  implicit none

contains

  function trithemius_default_key() result(k)
    character(len=3) :: k
    k = "ABC"
  end function trithemius_default_key

  function trithemius_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function trithemius_key_valid

end module trithemius_keys
