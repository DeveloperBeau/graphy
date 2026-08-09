module columnar_keys
  ! Key material helpers for the columnar cipher.
  implicit none

contains

  function columnar_default_key() result(k)
    integer :: k
    k = 4
  end function columnar_default_key

  function columnar_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function columnar_key_valid

end module columnar_keys
