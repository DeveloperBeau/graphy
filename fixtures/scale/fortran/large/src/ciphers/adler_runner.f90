module adler_runner
  ! Benchmark runner for the adler cipher.
  use adler_cipher
  use adler_keys
  implicit none

contains

  function adler_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = adler_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function adler_run_bench

end module adler_runner
