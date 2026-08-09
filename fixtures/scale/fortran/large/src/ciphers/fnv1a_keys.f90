module fnv1a_keys
  ! Key material helpers for the fnv1a cipher.
  implicit none

contains

  function fnv1a_default_key() result(k)
    integer :: k
    k = 40389
  end function fnv1a_default_key

  function fnv1a_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function fnv1a_key_valid

end module fnv1a_keys
