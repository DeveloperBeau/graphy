module beaufort_runner
  ! Benchmark runner for the beaufort cipher.
  use beaufort_cipher
  use beaufort_keys
  implicit none

contains

  function beaufort_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = beaufort_encrypt(sample)
    end do
    outlen = size(out)
  end function beaufort_run_bench

end module beaufort_runner
