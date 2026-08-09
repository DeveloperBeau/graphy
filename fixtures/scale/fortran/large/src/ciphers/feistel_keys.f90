module feistel_keys
  ! Key material helpers for the feistel cipher.
  implicit none

contains

  function feistel_default_key() result(k)
    integer :: k
    k = 101
  end function feistel_default_key

  function feistel_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function feistel_key_valid

end module feistel_keys
