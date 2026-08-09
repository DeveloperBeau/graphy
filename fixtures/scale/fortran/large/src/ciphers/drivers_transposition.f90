module drivers_transposition
  ! Sequential benchmark driver for the transposition family.
  use railfence_runner
  use columnar_runner
  use scytale_runner
  use revblocks_runner
  use zigzag_runner
  use blockswap_runner
  use rotblocks_runner
  use interleave_runner
  use stride_runner
  use bench_registry
  implicit none

contains

  subroutine run_transposition_family(sample, rounds, total)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer, intent(inout) :: total
    call register_family("transposition")
    total = total + railfence_run_bench(sample, rounds)
    total = total + columnar_run_bench(sample, rounds)
    total = total + scytale_run_bench(sample, rounds)
    total = total + revblocks_run_bench(sample, rounds)
    total = total + zigzag_run_bench(sample, rounds)
    total = total + blockswap_run_bench(sample, rounds)
    total = total + rotblocks_run_bench(sample, rounds)
    total = total + interleave_run_bench(sample, rounds)
    total = total + stride_run_bench(sample, rounds)
  end subroutine run_transposition_family

end module drivers_transposition
