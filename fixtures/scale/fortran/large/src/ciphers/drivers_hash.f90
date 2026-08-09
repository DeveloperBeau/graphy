module drivers_hash
  ! Sequential benchmark driver for the hash family.
  use fnv1a_runner
  use djb2_runner
  use sdbm_runner
  use adler_runner
  use sum32_runner
  use xordigest_runner
  use crclite_runner
  use rothash_runner
  use prodhash_runner
  use bench_registry
  implicit none

contains

  subroutine run_hash_family(sample, rounds, total)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer, intent(inout) :: total
    call register_family("hash")
    total = total + fnv1a_run_bench(sample, rounds)
    total = total + djb2_run_bench(sample, rounds)
    total = total + sdbm_run_bench(sample, rounds)
    total = total + adler_run_bench(sample, rounds)
    total = total + sum32_run_bench(sample, rounds)
    total = total + xordigest_run_bench(sample, rounds)
    total = total + crclite_run_bench(sample, rounds)
    total = total + rothash_run_bench(sample, rounds)
    total = total + prodhash_run_bench(sample, rounds)
  end subroutine run_hash_family

end module drivers_hash
