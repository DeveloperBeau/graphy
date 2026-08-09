module porta_runner
  ! Benchmark runner for the porta cipher.
  use porta_cipher
  use porta_keys
  implicit none

contains

  function porta_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = porta_encrypt(sample)
    end do
    outlen = size(out)
  end function porta_run_bench

end module porta_runner
