module maskstream_runner
  ! Benchmark runner for the maskstream cipher.
  use maskstream_cipher
  use maskstream_keys
  implicit none

contains

  function maskstream_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = maskstream_encrypt(sample)
    end do
    outlen = size(out)
  end function maskstream_run_bench

end module maskstream_runner
