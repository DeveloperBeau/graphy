module drivers_vigenere
  ! Sequential benchmark driver for the vigenere family.
  use vigenere_runner
  use beaufort_runner
  use autokey_runner
  use gronsfeld_runner
  use porta_runner
  use runkey_runner
  use keymix_runner
  use trithemius_runner
  use quagmire_runner
  use bench_registry
  implicit none

contains

  subroutine run_vigenere_family(sample, rounds, total)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer, intent(inout) :: total
    call register_family("vigenere")
    total = total + vigenere_run_bench(sample, rounds)
    total = total + beaufort_run_bench(sample, rounds)
    total = total + autokey_run_bench(sample, rounds)
    total = total + gronsfeld_run_bench(sample, rounds)
    total = total + porta_run_bench(sample, rounds)
    total = total + runkey_run_bench(sample, rounds)
    total = total + keymix_run_bench(sample, rounds)
    total = total + trithemius_run_bench(sample, rounds)
    total = total + quagmire_run_bench(sample, rounds)
  end subroutine run_vigenere_family

end module drivers_vigenere
