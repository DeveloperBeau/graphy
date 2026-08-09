module verifiers_transposition
  ! Round-trip verification driver for the transposition family.
  use railfence_check
  use columnar_check
  use scytale_check
  use revblocks_check
  use zigzag_check
  use blockswap_check
  use rotblocks_check
  use interleave_check
  use stride_check
  implicit none

contains

  subroutine verify_transposition_family(sample, failures)
    integer, intent(in) :: sample(:)
    integer, intent(inout) :: failures
    if (.not. railfence_verify(sample)) failures = failures + 1
    if (.not. columnar_verify(sample)) failures = failures + 1
    if (.not. scytale_verify(sample)) failures = failures + 1
    if (.not. revblocks_verify(sample)) failures = failures + 1
    if (.not. zigzag_verify(sample)) failures = failures + 1
    if (.not. blockswap_verify(sample)) failures = failures + 1
    if (.not. rotblocks_verify(sample)) failures = failures + 1
    if (.not. interleave_verify(sample)) failures = failures + 1
    if (.not. stride_verify(sample)) failures = failures + 1
  end subroutine verify_transposition_family

end module verifiers_transposition
