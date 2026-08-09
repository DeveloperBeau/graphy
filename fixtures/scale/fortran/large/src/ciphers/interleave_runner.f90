module interleave_runner
  ! Benchmark runner for the interleave cipher.
  use interleave_cipher
  use interleave_keys
  implicit none

contains

  function interleave_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = interleave_encrypt(sample)
    end do
    outlen = size(out)
  end function interleave_run_bench

end module interleave_runner
