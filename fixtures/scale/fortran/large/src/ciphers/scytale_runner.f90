module scytale_runner
  ! Benchmark runner for the scytale cipher.
  use scytale_cipher
  use scytale_keys
  implicit none

contains

  function scytale_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer :: out(size(sample))
    out = sample
    do r = 1, rounds
      out = scytale_encrypt(sample)
    end do
    outlen = size(out)
  end function scytale_run_bench

end module scytale_runner
