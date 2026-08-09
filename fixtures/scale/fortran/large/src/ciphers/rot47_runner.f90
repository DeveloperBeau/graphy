module rot47_runner
  ! Benchmark runner for the rot47 cipher.
  use rot47_cipher
  use rot47_keys
  implicit none

contains

  function rot47_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = rot47_encrypt(sample)
    end do
    outlen = size(out)
  end function rot47_run_bench

end module rot47_runner
