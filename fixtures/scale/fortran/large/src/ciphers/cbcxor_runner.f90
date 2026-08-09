module cbcxor_runner
  ! Benchmark runner for the cbcxor cipher.
  use cbcxor_cipher
  use cbcxor_keys
  implicit none

contains

  function cbcxor_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = cbcxor_encrypt(sample)
    end do
    outlen = size(out)
  end function cbcxor_run_bench

end module cbcxor_runner
