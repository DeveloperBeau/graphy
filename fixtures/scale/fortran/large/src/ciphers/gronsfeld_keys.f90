module gronsfeld_keys
  ! Key material helpers for the gronsfeld cipher.
  implicit none

contains

  function gronsfeld_default_key() result(k)
    character(len=5) :: k
    k = "31415"
  end function gronsfeld_default_key

  function gronsfeld_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function gronsfeld_key_valid

end module gronsfeld_keys
