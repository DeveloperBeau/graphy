module xorbasic_runner
  ! Benchmark runner for the xorbasic cipher.
  use xorbasic_cipher
  use xorbasic_keys
  implicit none

contains

  function xorbasic_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = xorbasic_encrypt(sample)
    end do
    outlen = size(out)
  end function xorbasic_run_bench

end module xorbasic_runner
