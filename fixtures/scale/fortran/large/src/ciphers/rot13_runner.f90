module rot13_runner
  ! Benchmark runner for the rot13 cipher.
  use rot13_cipher
  use rot13_keys
  implicit none

contains

  function rot13_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = rot13_encrypt(sample)
    end do
    outlen = size(out)
  end function rot13_run_bench

end module rot13_runner
