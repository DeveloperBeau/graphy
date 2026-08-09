module runkey_runner
  ! Benchmark runner for the runkey cipher.
  use runkey_cipher
  use runkey_keys
  implicit none

contains

  function runkey_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = runkey_encrypt(sample)
    end do
    outlen = size(out)
  end function runkey_run_bench

end module runkey_runner
