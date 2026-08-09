module affine_keys
  ! Key material helpers for the affine cipher.
  implicit none

contains

  function affine_default_key() result(k)
    integer :: k
    k = 8
  end function affine_default_key

  function affine_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function affine_key_valid

end module affine_keys
