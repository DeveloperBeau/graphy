module prodhash_runner
  ! Benchmark runner for the prodhash cipher.
  use prodhash_cipher
  use prodhash_keys
  implicit none

contains

  function prodhash_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = prodhash_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function prodhash_run_bench

end module prodhash_runner
