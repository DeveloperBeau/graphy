module shift5_runner
  ! Benchmark runner for the shift5 cipher.
  use shift5_cipher
  use shift5_keys
  implicit none

contains

  function shift5_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = shift5_encrypt(sample)
    end do
    outlen = size(out)
  end function shift5_run_bench

end module shift5_runner
