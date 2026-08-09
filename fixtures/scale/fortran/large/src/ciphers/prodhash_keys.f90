module prodhash_keys
  ! Key material helpers for the prodhash cipher.
  implicit none

contains

  function prodhash_default_key() result(k)
    integer :: k
    k = 7
  end function prodhash_default_key

  function prodhash_key_valid(k) result(ok)
    integer, intent(in) :: k
    logical :: ok
    ok = k >= 0
  end function prodhash_key_valid

end module prodhash_keys
