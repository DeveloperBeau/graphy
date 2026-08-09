module decimation_runner
  ! Benchmark runner for the decimation cipher.
  use decimation_cipher
  use decimation_keys
  implicit none

contains

  function decimation_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = decimation_encrypt(sample)
    end do
    outlen = size(out)
  end function decimation_run_bench

end module decimation_runner
