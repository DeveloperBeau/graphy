module rc4lite_keys
  ! Key material helpers for the rc4lite cipher.
  implicit none

contains

  function rc4lite_default_key() result(k)
    integer :: k
    k = 17
  end function rc4lite_default_key

  function rc4lite_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function rc4lite_key_valid

end module rc4lite_keys
