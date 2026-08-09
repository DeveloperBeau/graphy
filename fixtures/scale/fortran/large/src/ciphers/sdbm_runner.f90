module sdbm_runner
  ! Benchmark runner for the sdbm cipher.
  use sdbm_cipher
  use sdbm_keys
  implicit none

contains

  function sdbm_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = sdbm_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function sdbm_run_bench

end module sdbm_runner
