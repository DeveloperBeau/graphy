module maskstream_keys
  ! Key material helpers for the maskstream cipher.
  implicit none

contains

  function maskstream_default_key() result(k)
    integer :: k
    k = 90
  end function maskstream_default_key

  function maskstream_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function maskstream_key_valid

end module maskstream_keys
