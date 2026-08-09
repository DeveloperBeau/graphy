module verifiers_hash
  ! Round-trip verification driver for the hash family.
  use fnv1a_check
  use djb2_check
  use sdbm_check
  use adler_check
  use sum32_check
  use xordigest_check
  use crclite_check
  use rothash_check
  use prodhash_check
  implicit none

contains

  subroutine verify_hash_family(sample, failures)
    integer, intent(in) :: sample(:)
    integer, intent(inout) :: failures
    if (.not. fnv1a_verify(sample)) failures = failures + 1
    if (.not. djb2_verify(sample)) failures = failures + 1
    if (.not. sdbm_verify(sample)) failures = failures + 1
    if (.not. adler_verify(sample)) failures = failures + 1
    if (.not. sum32_verify(sample)) failures = failures + 1
    if (.not. xordigest_verify(sample)) failures = failures + 1
    if (.not. crclite_verify(sample)) failures = failures + 1
    if (.not. rothash_verify(sample)) failures = failures + 1
    if (.not. prodhash_verify(sample)) failures = failures + 1
  end subroutine verify_hash_family

end module verifiers_hash
