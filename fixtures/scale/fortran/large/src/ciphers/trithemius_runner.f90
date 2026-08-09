module trithemius_runner
  ! Benchmark runner for the trithemius cipher.
  use trithemius_cipher
  use trithemius_keys
  implicit none

contains

  function trithemius_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = trithemius_encrypt(sample)
    end do
    outlen = size(out)
  end function trithemius_run_bench

end module trithemius_runner
