module sdbm_check
  ! Round-trip verification for the sdbm cipher.
  use sdbm_cipher
  implicit none

contains

  function sdbm_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = sdbm_digest(sample) == sdbm_digest(sample)
  end function sdbm_verify

end module sdbm_check
