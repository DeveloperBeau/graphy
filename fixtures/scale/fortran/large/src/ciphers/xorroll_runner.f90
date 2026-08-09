module xorroll_runner
  ! Benchmark runner for the xorroll cipher.
  use xorroll_cipher
  use xorroll_keys
  implicit none

contains

  function xorroll_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = xorroll_encrypt(sample)
    end do
    outlen = size(out)
  end function xorroll_run_bench

end module xorroll_runner
