module railfence_keys
  ! Key material helpers for the railfence cipher.
  implicit none

contains

  function railfence_default_key() result(k)
    integer :: k
    k = 6
  end function railfence_default_key

  function railfence_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function railfence_key_valid

end module railfence_keys
