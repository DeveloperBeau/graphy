module columnar_runner
  ! Benchmark runner for the columnar cipher.
  use columnar_cipher
  use columnar_keys
  implicit none

contains

  function columnar_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = columnar_encrypt(sample)
    end do
    outlen = size(out)
  end function columnar_run_bench

end module columnar_runner
