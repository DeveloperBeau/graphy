module atbash_keys
  ! Key material helpers for the atbash cipher.
  implicit none

contains

  function atbash_default_key() result(k)
    integer :: k
    k = 3
  end function atbash_default_key

  function atbash_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function atbash_key_valid

end module atbash_keys
