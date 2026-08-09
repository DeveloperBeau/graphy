module verifiers_shift
  ! Round-trip verification driver for the shift family.
  use caesar_check
  use rot13_check
  use rot47_check
  use shift5_check
  use atbash_check
  use affine_check
  use decimation_check
  use addmod_check
  use rotmix_check
  implicit none

contains

  subroutine verify_shift_family(sample, failures)
    integer, intent(in) :: sample(:)
    integer, intent(inout) :: failures
    if (.not. caesar_verify(sample)) failures = failures + 1
    if (.not. rot13_verify(sample)) failures = failures + 1
    if (.not. rot47_verify(sample)) failures = failures + 1
    if (.not. shift5_verify(sample)) failures = failures + 1
    if (.not. atbash_verify(sample)) failures = failures + 1
    if (.not. affine_verify(sample)) failures = failures + 1
    if (.not. decimation_verify(sample)) failures = failures + 1
    if (.not. addmod_verify(sample)) failures = failures + 1
    if (.not. rotmix_verify(sample)) failures = failures + 1
  end subroutine verify_shift_family

end module verifiers_shift
