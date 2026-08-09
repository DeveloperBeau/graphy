module drivers_shift
  ! Sequential benchmark driver for the shift family.
  use caesar_runner
  use rot13_runner
  use rot47_runner
  use shift5_runner
  use atbash_runner
  use affine_runner
  use decimation_runner
  use addmod_runner
  use rotmix_runner
  use bench_registry
  implicit none

contains

  subroutine run_shift_family(sample, rounds, total)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer, intent(inout) :: total
    call register_family("shift")
    total = total + caesar_run_bench(sample, rounds)
    total = total + rot13_run_bench(sample, rounds)
    total = total + rot47_run_bench(sample, rounds)
    total = total + shift5_run_bench(sample, rounds)
    total = total + atbash_run_bench(sample, rounds)
    total = total + affine_run_bench(sample, rounds)
    total = total + decimation_run_bench(sample, rounds)
    total = total + addmod_run_bench(sample, rounds)
    total = total + rotmix_run_bench(sample, rounds)
  end subroutine run_shift_family

end module drivers_shift
