module gronsfeld_runner
  ! Benchmark runner for the gronsfeld cipher.
  use gronsfeld_cipher
  use gronsfeld_keys
  implicit none

contains

  function gronsfeld_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = gronsfeld_encrypt(sample)
    end do
    outlen = size(out)
  end function gronsfeld_run_bench

end module gronsfeld_runner
