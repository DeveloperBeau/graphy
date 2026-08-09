module rothash_runner
  ! Benchmark runner for the rothash cipher.
  use rothash_cipher
  use rothash_keys
  implicit none

contains

  function rothash_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = rothash_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function rothash_run_bench

end module rothash_runner
