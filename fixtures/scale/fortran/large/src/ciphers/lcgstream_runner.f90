module lcgstream_runner
  ! Benchmark runner for the lcgstream cipher.
  use lcgstream_cipher
  use lcgstream_keys
  implicit none

contains

  function lcgstream_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = lcgstream_encrypt(sample)
    end do
    outlen = size(out)
  end function lcgstream_run_bench

end module lcgstream_runner
