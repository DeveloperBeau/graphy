module drivers_stream
  ! Sequential benchmark driver for the stream family.
  use xorbasic_runner
  use xorroll_runner
  use rc4lite_runner
  use lcgstream_runner
  use xorshift_runner
  use feistel_runner
  use cbcxor_runner
  use ctrxor_runner
  use maskstream_runner
  use bench_registry
  implicit none

contains

  subroutine run_stream_family(sample, rounds, total)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer, intent(inout) :: total
    call register_family("stream")
    total = total + xorbasic_run_bench(sample, rounds)
    total = total + xorroll_run_bench(sample, rounds)
    total = total + rc4lite_run_bench(sample, rounds)
    total = total + lcgstream_run_bench(sample, rounds)
    total = total + xorshift_run_bench(sample, rounds)
    total = total + feistel_run_bench(sample, rounds)
    total = total + cbcxor_run_bench(sample, rounds)
    total = total + ctrxor_run_bench(sample, rounds)
    total = total + maskstream_run_bench(sample, rounds)
  end subroutine run_stream_family

end module drivers_stream
