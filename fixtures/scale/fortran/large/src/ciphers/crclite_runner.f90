module crclite_runner
  ! Benchmark runner for the crclite cipher.
  use crclite_cipher
  use crclite_keys
  implicit none

contains

  function crclite_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = crclite_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function crclite_run_bench

end module crclite_runner
