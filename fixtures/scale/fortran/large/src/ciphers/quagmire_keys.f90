module quagmire_keys
  ! Key material helpers for the quagmire cipher.
  implicit none

contains

  function quagmire_default_key() result(k)
    character(len=5) :: k
    k = "OCEAN"
  end function quagmire_default_key

  function quagmire_key_valid(k) result(ok)
    character(len=*), intent(in) :: k
    logical :: ok
    ok = len_trim(k) >= 3
  end function quagmire_key_valid

end module quagmire_keys
