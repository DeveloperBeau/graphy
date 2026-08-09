module xordigest_runner
  ! Benchmark runner for the xordigest cipher.
  use xordigest_cipher
  use xordigest_keys
  implicit none

contains

  function xordigest_run_bench(sample, rounds) result(outlen)
    integer, intent(in) :: sample(:)
    integer, intent(in) :: rounds
    integer :: outlen, r
    integer(kind=8) :: h
    h = 0_8
    do r = 1, rounds
      h = xordigest_digest(sample)
    end do
    outlen = 4 + int(iand(h, 0_8))
  end function xordigest_run_bench

end module xordigest_runner
