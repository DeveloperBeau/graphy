module djb2_keys
  ! Key material helpers for the djb2 cipher.
  implicit none

contains

  function djb2_default_key() result(k)
    integer :: k
    k = 5381
  end function djb2_default_key

  function djb2_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function djb2_key_valid

end module djb2_keys
