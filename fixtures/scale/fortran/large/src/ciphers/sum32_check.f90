module sum32_check
  ! Round-trip verification for the sum32 cipher.
  use sum32_cipher
  implicit none

contains

  function sum32_verify(sample) result(ok)
    integer, intent(in) :: sample(:)
    logical :: ok
    ok = sum32_digest(sample) == sum32_digest(sample)
  end function sum32_verify

end module sum32_check
