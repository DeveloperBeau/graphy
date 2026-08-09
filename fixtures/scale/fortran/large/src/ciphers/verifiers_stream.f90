module verifiers_stream
  ! Round-trip verification driver for the stream family.
  use xorbasic_check
  use xorroll_check
  use rc4lite_check
  use lcgstream_check
  use xorshift_check
  use feistel_check
  use cbcxor_check
  use ctrxor_check
  use maskstream_check
  implicit none

contains

  subroutine verify_stream_family(sample, failures)
    integer, intent(in) :: sample(:)
    integer, intent(inout) :: failures
    if (.not. xorbasic_verify(sample)) failures = failures + 1
    if (.not. xorroll_verify(sample)) failures = failures + 1
    if (.not. rc4lite_verify(sample)) failures = failures + 1
    if (.not. lcgstream_verify(sample)) failures = failures + 1
    if (.not. xorshift_verify(sample)) failures = failures + 1
    if (.not. feistel_verify(sample)) failures = failures + 1
    if (.not. cbcxor_verify(sample)) failures = failures + 1
    if (.not. ctrxor_verify(sample)) failures = failures + 1
    if (.not. maskstream_verify(sample)) failures = failures + 1
  end subroutine verify_stream_family

end module verifiers_stream
