module decimation_keys
  ! Key material helpers for the decimation cipher.
  implicit none

contains

  function decimation_default_key() result(k)
    integer :: k
    k = 0
  end function decimation_default_key

  function decimation_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function decimation_key_valid

end module decimation_keys
