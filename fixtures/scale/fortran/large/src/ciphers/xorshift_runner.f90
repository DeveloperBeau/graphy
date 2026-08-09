module xorshift_runner
  ! Benchmark runner for the xorshift cipher.
  use xorshift_cipher
  use xorshift_keys
  implicit none

contains

  function xorshift_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = xorshift_encrypt(sample)
    end do
    outlen = size(out)
  end function xorshift_run_bench

end module xorshift_runner
