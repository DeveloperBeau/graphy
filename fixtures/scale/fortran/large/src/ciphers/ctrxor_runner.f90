module ctrxor_runner
  ! Benchmark runner for the ctrxor cipher.
  use ctrxor_cipher
  use ctrxor_keys
  implicit none

contains

  function ctrxor_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = ctrxor_encrypt(sample)
    end do
    outlen = size(out)
  end function ctrxor_run_bench

end module ctrxor_runner
