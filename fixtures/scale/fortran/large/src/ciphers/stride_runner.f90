module stride_runner
  ! Benchmark runner for the stride cipher.
  use stride_cipher
  use stride_keys
  implicit none

contains

  function stride_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = stride_encrypt(sample)
    end do
    outlen = size(out)
  end function stride_run_bench

end module stride_runner
