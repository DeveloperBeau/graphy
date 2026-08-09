module zigzag_runner
  ! Benchmark runner for the zigzag cipher.
  use zigzag_cipher
  use zigzag_keys
  implicit none

contains

  function zigzag_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = zigzag_encrypt(sample)
    end do
    outlen = size(out)
  end function zigzag_run_bench

end module zigzag_runner
